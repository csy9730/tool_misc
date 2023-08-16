# RTTI和反射的基本概念

JJH的创世纪

于 2018-11-05 19:04:03 发布

160
 收藏
文章标签： RTTI 反射
版权
JAVA有两种方式使得我们在程序运行时识别对象和类的信息：一种是传统的RTTI，另一种是反射。

RTTI(Run-Time Type Identification)运行时类型识别，运行时类型信息可以使得你在程序运行时发现和使用类型信息。

## 为什么要RTTI

来看一个例子，这个例子使用的多态的类层次结构，通用类型泛型（Shape），派生的具体类Circle，Square，Triangle。

类图：



面向对象编程的基本目的是：让代码只操作对基类的应用（这里是Shape）。这样，当我们需要扩展具体类时不会影响到源代码。这个例子中的Shape接口中动态绑定了draw（）方法，目的就是让程序员使用泛化的Shape引用（向上转型）来调用draw（）方法。draw（）在具体类中被覆盖，但是用于动态绑定的效果，具体类可以产生正确的行为（多态）。

那么问题来了，在程序运行的时候，系统怎么知道Circle是Shape的派生类呢（子类）。这里就体现了RTTI的作用：在程序运行时，识别一个对象的类型。

看看代码：

```java


public interface Shape {
	void draw();
}

public class Circle implements Shape {
	@Override
	public void draw() {
		System.out.println("Circle draw()...");
	}
}

public class Square implements Shape {

​```
@Override
public void draw() {
	System.out.println("Square draw()...");
 
}
​```

}

public class Triangel implements Shape {

​```
@Override
public void draw() {
	System.out.println("Triangel draw()...");
}
​```

}

public class Main {
	public static void main(String[] args) {
		List<Shape> lists=Arrays.asList(new Circle(),new Square(),new Triangel());
		

​```
	for (Shape shape : lists) {
		shape.draw();
	}
}
​```

}

/*
    Output:
Circle draw()...
Square draw()...
Triangel draw()...
*/
```




在这个例子中，当吧Shape对象放入List<Shape>的集合时会使用向上转型，但在向上转型为Shape的时候也丢失了Shape的具体类型，对于list集合而言，它就是Shape类型。

而shape对象具体执行什么代码，是由引用所指向的具体对象circle，square，triangle所决定的。

我们不希望了解每个对象长什么样子，实际上我们只需要和一个通用的类型打交道就好了，这样代码会更容易些，更容易读，维护和设计也更容易（体现了多态的基本目标）。

## 反射：运行时的类型信息
如果不知道某个对象的类型，RTTI可以告诉你，但是有一个限制：这个类型在编译时必须已知，这样RTTI才能识别它。

但是如果在编译时程序没有办法获取这个对象所属的类，例如在网络连接中获取一串字节，并且你被告知这段字节代表一个类，既然这个类在程序生成代码之后才会出现（未编译），那RTTI怎么识别呢。

人们想要在运行时获取类的信息的一个动机是，希望提供在跨网络的远程平台上创建和运行对象的能力，这被称为远程方法调用（RMI），它允许一个java程序将对象分布到多台机器上（分布式系统）提供，反射提供一种机制-用来检查可用的方法，并返回方法名。

Class类余额java.lang.reflect类库一起对反射的概念进行了支持，该类库包括了Field，Method以及Constructor类（每个类都四线了Member接口），这些类型的对象是由JVM在运行时创建的，用以表示位置类里对应额成员。

Constructor：创建新的对象，用get（）和set（）方法读取和修改与Field对象关联的对象。用invoke（）方法调用与Method对象关联的方法。

用getField（），getMethods（）和getConstruct（）等便利的方法，已返回表示字段，方法，构造器的对象数组。

这样，匿名对象的类信息就能在运行时被完全确定下来，而在编译时不需要知道任何事情。

当反射与一个未知类型的对象打交道时，JVM（java虚拟机）只是简单的检查这个对象，看它属于哪个特定的类（与RTTI一样），在使用这个类时先加载这个类的Class对象。因此这个类型的.class文件对于JVM来说必须是可获取的，要么在本机上，要么在网络上（通过下载访问，实际上也是存在某个本地磁盘里）。

所以RTTI和反射的区别是，对于RTTI来说，编译器在编译时打开和检查.class文件（通俗点说，我们用‘通常’的方式调用对象的所有方法---new一个对象），而对于反射机制，.class在编译时时不可获取的，所以是在运行是打开和检查.class文件。
————————————————
版权声明：本文为CSDN博主「JJH的创世纪」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/ck784101777/article/details/83620478