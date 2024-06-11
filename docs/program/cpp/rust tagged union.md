# rust tagged union

### rust tagged union
rustc中，编译流程大致如下：
- Text：程序源码
- AST：parsing
- HIR：high-level intermediate representation，通过了type checking。相当于AST + type info
- MIR：middle-level intermediate representation，通过borrow checking，是一个control diagram
- backend：一般是LLVM IR，然后通过LLVM编译到可执行文件

首先，rustc中每个类型都有几个重要属性，在源码中经常会看见：
- ZST （zero sized type) 也就是不需要任何内存表示的类型，这种类型只有一个实例，并且对应的值固定；
- uninhabited type也就是不存在实例的类型，如!。
- rustc还追踪一个类型的连续未定义域，最终用到一个叫niche optimization的优化上。


在rustc中，每个类型的size都会被追踪，以上是前提。这些类型信息在HIR都会被确定下来并且得知。简单来说，rustc的codegen和C++差不多，都是每个实例生成一个二进制函数，命名问题通过mangling来解决。在HIR到MIR的转化时存在一个monomorphization的过程：

在这个过程当中，所有的泛型都会被实例化，所产生的MIR是没有泛型的（monomorphized）[1]。当从MIR转换到LLVM IR时，rustc只需要考虑已经实例化的类型即可。这里有几种情况[2]：一些已知基本类型需要hard code，这些类型为整型，浮点，char，诸如此类。注意builtin types不一定都如整型每一个bit pattern都有意义。比方说bool是1 byte，但是只有两个值0和1，所以rustc会记下bool的值域是0-1，而2-255为未定义。struct基本上是递归下去。但是rustc中有个优化就是基于已知的size信息，排列组合出一个需要最少padding的field的顺序。引用和指针存在一个thin和fat pointer的区别，这里有点复杂，我不太记得，按下不表。enum则是这个问题问的。已经有答主给出了一些optimization，我这里再强调这中间的两种情况和再解释清楚其中一个非常重要的优化，niche optimization。

#### tagged union
首先最基本的是tagged union。这个情况下，rust一般再加一个整型（一般是4 byte，有例外）用作tag，然后每个case都是一个struct，最后在union起来。比方说[3]
``` rust
enum Message {
    Quit,
    Move { x: i32, y: i32 },
    ChangeColor(i32, i32, i32),
}
```
在C中大概写成
``` cpp
struct Message {
    int tag;
    union {
        struct {} Quit;
        struct {
            int32_t x, y;
        } Move;
        struct {
            int32_t _1, _2, _3;
        } ChangeColor;
    } cases;
}
```
这是最基础的形式。

但是这种形式却是不尽如人意。比如Option<&i32> 如用tagged union的话则在64bit系统用到了8 + 4 = 12 bytes，多用了4bytes。因为&i32不可能是null，我们完全可以将其编译到8 bytes。
#### niche optimization
有些类型的有效二进制取值不会覆盖所有空间，剩余的无效取值可以用来表示其他东西。这种利用类型定义域剩余空间的优化被称为 niche optimization。


niche optimization则解决了这个问题。给定下面的
``` c
enum Foo {
    C1(x1, ..., xn),
    C2,
    ...
    Cm
}
```
这种形式的enum只有一个case有field。首先C1按照struct算出合适的field的顺序。每个field找出（连续）未定义域最大的。比方说如果C1有bool和&i32，bool从2-255未定义而&i32只有0，那么rustc则选出这个bool的field，称之为niche。 然后再比较这个未定义域的大小k与m-1，如m-1大，则niche optimization不成立，只能用tagged union。否则， 从niche的未定义域中由小选出m-1个值代表C2到Cm。这也可以得出Foo 的niche及其未定义域。未定义域的大小变为k-(m-1)。 比方说

``` cpp
enum Foo {
    C1(&i32, bool),
    C2,
    C3
}
```

可以被优化成
``` cpp
struct Foo {
    int32_t *_1;
    uint8_t _2;    
}
```
当_2为0或者1时Foo表示C1，为2时表示C2，为3时表示C3。 后两种情况下的_1的值未定义。


这里要注意的是，每个泛型实例的layout都不一定一样。比方说Option<i32>表示为tagged union因为i32没有未定义域。但是Option<&i32>通过niche optimization直接变成一个指针，因为&i32在null为定义，所以Nonecase编译成了null

