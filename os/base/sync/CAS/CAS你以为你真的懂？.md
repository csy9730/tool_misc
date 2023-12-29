# CAS你以为你真的懂？

[![小码逆袭](https://picx.zhimg.com/v2-454000057311ff0cae224b404cff17e0_l.jpg?source=172ae18b)](https://www.zhihu.com/people/chi-ge-ye-zi-ya-ya-liang)

[小码逆袭](https://www.zhihu.com/people/chi-ge-ye-zi-ya-ya-liang)

正青春，描绘我的程序人生

19 人赞同了该文章



## CAS是个啥

CAS（Compare and swap）直译过来就是比较和替换，也有人叫compare and exchange，是一种通过硬件实现并发安全的常用技术，底层通过利用CPU的CAS指令对缓存加锁或总线加锁的方式来实现多处理器之间的原子操作。仔细观察J.U.C包中类的实现代码，会发现这些类中大量使用到了CAS，所以CAS是Java并发包的实现基础。它的实现过程是，有3个操作数，内存值V，旧的预期值E，要修改的新值N，当且仅当预期值E和内存值V相同时，才将内存值V修改为N，否则什么都不做。

原文链接：[【吊打面试官系列】CAS你以为你真的懂？](https://link.zhihu.com/?target=https%3A//blog.csdn.net/lyztyycode/article/details/105343010)

## 一图看懂CAS的操作流程

![img](https://pic1.zhimg.com/80/v2-b61f4ffcedcffcff11d53f4855abdd20_720w.webp)

## 从源码看CAS，你大彻大悟

下面看两个测试代码：

```java
public class CasAndUnsafe_01 {
    private static  int m = 0;
 
    public static void main(String[] args) throws InterruptedException {
        Thread[] threads = new Thread[100];
        final CoutDownLatch latch = new CoutDownLatch(threads.length);
        
        Object o = new Object();
        
        for(int i = 0; i < threads.length; i++){
            threads[i] = new Thread(()->{
                synchronized (o){
                    for(int j = 0; j <10000; j++){
                        m++;
                    }
                    latch.countDown();
                }
            });
        }
        Arrays.stream(threads).forEach((t)-> t.start());
        latch.await();
        System.out.println(m);
    }
}
```

代码很简单，每个线程都对m做++操作，众所周知，由于m++不是原子操作，从CPU级别来看，m++经历了3步，取，加，存3步操作，所以在这之间就有可能出现线程并发的问题。加上一个synchronized 重量级锁就避免了这个问题。

如果不想用synchronized，不想加锁，可能很多人都用过AtomicInteger。实现如下。

```java
public class AtomicInteger_01 {
    private static AtomicInteger m = new AtomicInteger(0);
 
    public static void main(String[] args) throws InterruptedException {
 
        Thread[] threads = new Thread[100];
 
        CountDownLatch latch = new CountDownLatch(threads.length);
 
        Object o = new Object();
 
        for(int i = 0; i < threads.length; i++){
            threads[i] = new Thread(()->{
                for(int j = 0; j < 10000; j++){
                    //m++
                    m.incrementAndGet();
                }
                latch.countDown();
            });
        }
 
        Arrays.stream(threads).forEach((t)-> t.start());
        latch.await();
    }
}
```

AtomicInteger 是JUC出来后为大家提供的原子类，这里面的操作都是原子操作， m.incrementAndGet()增加并获取，这就是一个CAS操作，我们再也不用加锁了。

PS：很多人喜欢叫CAS为无锁，我很不喜欢这个叫法，准确的说CAS是自旋锁。**为什么说不能叫无锁呢？**

我们从源码探究一下CAS底层是怎么实现的：从代码示例2的 m.incrementAndGet()我们跟进去。

```java
 /**
     * Atomically increments by one the current value.
     *
     * @return the updated value
     */
    public final int incrementAndGet() {
        return unsafe.getAndAddInt(this, valueOffset, 1) + 1;
    }
```

incrementAndGet你会发现它调用了一个类，这个类叫unsafe，调用了unsafe类里面的getAndAddInt。我们跟着进入到getAndAddInt方法中。

```java
 public final int getAndAddInt(Object var1, long var2, int var4) {
        int var5;
        do {
            var5 = this.getIntVolatile(var1, var2);
        } while(!this.compareAndSwapInt(var1, var2, var5, var5 + var4));
 
        return var5;
    }
```

这时候你发现getAndAddInt方法中调用了compareAndSwapInt方法，从名字不难看出这是一个CAS操作，操作的什么类型呢？Int类型，那么具体怎么操作呢，我们进入到这个方法内。

```text
 public final native boolean compareAndSwapInt(Object var1, long var2, int var4, int var5);
```

当你跟到这里的时候，你发现这是native 修饰的方法，native什么意思啊，native说明已经跟到C++的代码了。我们就来看一下C++中是怎么实现的CAS。下面是unsafe.cpp中代码实现。

```cpp
UNSAFE_ENTRY(jboolean, Unsafe_CompareAndSwapInt(JNIEnv *env, jobject unsafe, jobject obj, jlong offset, jint e, jint x))
  UnsafeWrapper("Unsafe_CompareAndSwapInt");
  oop p = JNIHandles::resolve(obj);
  jint* addr = (jint *) index_oop_from_field_offset_long(p, offset);
  return (jint)(Atomic::cmpxchg(x, addr, e)) == e;
UNSAFE_END
```

所以你在java中调用了compareAndSwapInt的话，实际上是调用了Unsafe_CompareAndSwapInt名字都一样，由于调用链很长我就不一一贴代码了，感兴趣的朋友可以自己找源码跟一下，我们直接跳到最根上。

***jdk8u：atomic_linux_x86.inline.hpp 的93行\***

```cpp
inline jint  Atomic::cmpxchg(jint exchange_value, volatile jint* dest, jint  compare_value) {
  int mp = os::is_MP();
  __asm__ volatile (LOCK_IF_MP(%4) "cmpxchgl %1,(%3)"
                    : "=a" (exchange_value)
                    : "r" (exchange_value), "a" (compare_value), "r" (dest), "r" (mp)
                    : "cc", "memory");
  return exchange_value;
}
```

我们从文件名字 atomic_linux_x86.inline.hpp 中就能获取到一些信息，说明到现在位置已经跟具体的平台和具体的cpu的型号关系了，在x86平台上linux版本的实现，那么CAS是怎么实现的呢？



看这条指令__asm__ volatile (LOCK_IF_MP(%4) "cmpxchgl %1,(%3)" 不知道你明白没有，看到这我们可以下一条结论，***原来在CPU层级有一条指令，叫cmpxchg\***。到这一步，你是不是觉得自己已经对于CAS已经理解的很透彻了呢？

***你有没有想过cmpxchg这条指令是原子操作吗？\***

![img](https://pic3.zhimg.com/80/v2-468857307eafcdc938dbe9a3cef953ba_720w.webp)

这个图怎么解释呢，就是一个线程a 取到了0的值，把0改为了1 ，正要把新值写回内存的时候，线程2抢先一步修改了内存中0的值，会不会有这样的情况发生呢，答案是肯定的，在并发层级很高的情况下，这种情况是完全可能发生的。问题就在于cmpxchg这条指令是不是原子性的。虽然在汇编层级有一条指令支持CAS,但是很遗憾它不是原子性的，那么怎么保证这条指令是原子性的呢？

不知道你们有没有注意到LOCK_IF_MP(%4)，从外观来看像是加锁的操作，我们进到LOCK_IF_MP这个方法内。

```text
#define LOCK_IF_MP(mp) "cmp $0, " #mp "; je 1f; lock; 1: "
```

前面的汇编我们忽略，你一定注意到了lock;1这是什么意思呢，从方法名字看lock if mp ，mp的全称是Multi Processor，多cpu，意思是什么呢，就是看你操作系统有多少个处理器，若果只有一个cpu一核的话就不需要原子性了，一定是顺序执行的，如果是多核心多cpu前面就要加lock，所以最红能够实现CAS的汇编指令就被我们揪出来了。***最终的汇编指令是lock cmpxchg 指令，lock指令在执行后面指令的时候锁定一个北桥信号\***(锁定北桥信号比锁定总线轻量一些，感兴趣的自己百度)。

所以***如果你是多核或者多个cpu，CPU在执行cmpxchg指令之前会执行lock锁定总线，实际是锁定北桥信号。我不释放这把锁谁也过不去，以此来保证cmpxchg的原子性\***。

## 总结

- CAS并不是真的无锁。
- 记住这条指令lock cmpxch！lock cmpxchg！lock cmpxchg！重要的事情说三遍！面试中这就是你的亮点！



编辑于 2020-04-07 23:41

[CAS](https://www.zhihu.com/topic/19674453)

[CSDN](https://www.zhihu.com/topic/19565864)

[计算机科学](https://www.zhihu.com/topic/19580349)