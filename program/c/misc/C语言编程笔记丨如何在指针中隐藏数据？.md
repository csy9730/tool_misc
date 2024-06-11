# C语言编程笔记丨如何在指针中隐藏数据？

编写 C 语言代码时，指针无处不在。我们可以稍微额外利用指针，在它们内部暗中存储一些额外信息。为实现这一技巧，我们利用了数据在内存中的自然对齐特性。

内存中的数据并非保存在任意地址。处理器通常按照其字大小相同的块读取内存数据；那么考虑到效率因素，编译器会按照块大小的整数倍对内存中的实体进行地址对齐。因此在 32 位的处理器上，一个 4 字节整型数据肯定存放在内存地址能被4整除的地方。

下面，假设系统中整型数据和指针大小均为4字节。

现在有一个指向整型的指针。如上所述，整型数据可以存放在内存地址 0x1000 或者 0x1004 或者 0x1008，但是决不会存放在 0x1001 或者0x1002 或者 0x1003 或者其他不能被4整除的任何地址。所有是4整数倍的二进制数都是以 00 结尾。实际上，这意味着对于所有指向整型的指针，它的最后两位总是 0。

那么有 2 比特没有承载任何信息。此处的技巧是将我们的数据放置到这两个比特中，在需要时使用，并在通过指针解引用来访问内存前删除它们。

由于 C 标准对指针位操作的支持不是很好，所以我们将指针保存为一个无符号整型数据。

下面是一段简短的简单代码片段。完整的代码查看 github 代码仓库中的hide-data-in-ptr。
``` cpp
void put_data(int *p, unsigned int data)
 
{
 
assert(data < 4);
 
*p |= data;
 
}
 
  
 
unsigned int get_data(unsigned int p)
 
{
 
return (p & 3);
 
}
 
  
 
void cleanse_pointer(int *p)
 
{
 
*p &= ~3;
 
}
 
  
 
int main(void)
 
{
 
unsigned int x = 701;
 
unsigned int p = (unsigned int) &x;
 
  
 
printf("Original ptr: %un", p);
 
  
 
put_data(&p, 3);
 
  
 
printf("ptr with data: %un", p);
 
printf("data stored in ptr: %un", get_data(p));
 
  
 
cleanse_pointer(&p);
 
  
 
printf("Cleansed ptr: %un", p);
 
printf("Dereferencing cleansed ptr: %un", *(int*)p);
 
  
 
return 0;
 
}
```

代码输出如下:

```
Original ptr:  3216722220
 
ptr with data: 3216722223
 
data stored in ptr: 3
 
Cleansed ptr:  3216722220
 
Dereferencing cleansed ptr: 701
```

我们可以在指针中存储任何可以用两个比特位表示的数据。使用 put_data() 函数，设置指针的最低两位为要存储的数据。该数据可以使用get_data() 函数获取。此处除了最后两位所有的位都被覆盖为零，于是我们隐藏的数据就显示出来。

cleanse_pointer() 函数将最低两位置零，保证指针安全地解引用。注意虽然有些 CPU（像 Intel 允许我们访问未对齐内存地址，但其余 CPU（像 ARM）会出现访问错误。所以，要牢记在解引用前保证指针指向已对齐内存地址。

这在实际中有应用吗？

是的，有应用。查看 Linux 内核中红黑树的实现（链接）。

树的结点定义如下：

``` c
struct rb_node {
 
unsigned long  __rb_parent_color;
 
struct rb_node *rb_right;
 
struct rb_node *rb_left;
 
} __attribute__((aligned(sizeof(long))));
```
此处 unsigned long __rb_parent_color 存储了如下信息：

（1）父节点的地址

（2）结点的颜色

（3）色彩的表示用 0 代表红色，1 代表黑色。

和前面的例子一样，该数据隐藏在父指针“无用的”比特位中。

下面看一下父指针和色彩信息是如何获取的：

``` c
/* in rbtree.h */
 
#define rb_parent(r)   ((struct rb_node *)((r)->__rb_parent_color & ~3))

/* in rbtree_augmented.h */
 
#define __rb_color(pc)     ((pc) & 1)
 
#define rb_color(rb)       __rb_color((rb)->__rb_parent_color)
```

内存中每一比特都很珍贵，咱们永远不要浪费。——（本文作者）

博主是一个有着7年工作经验的架构师，对于c++，自己有做资料的整合，一个完整学习C语言c++的路线，学习资料和工具。可以进我的Q群7418,18652领取，免费送给大家。希望你也能凭自己的努力，成为下一个优秀的程序员！另外博主的微信公众号是：C语言编程学习基地，欢迎关注！

如果说我的文章对你有用，只不过是我站在巨人的肩膀上再继续努力罢了。
若在页首无特别声明，本篇文章由 Schips 经过整理后发布。
博客地址：https://www.cnblogs.com/schips/
标签: c/c++