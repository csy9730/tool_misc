# Bloom Filter 主流Hash散列算法介绍

Frank123721

于 2014-11-13 20:46:09 发布

2872
 收藏 1
分类专栏： 数据结构 云计算 文章标签： 算法 散列函数 bloom filter hash
版权

数据结构
同时被 2 个专栏收录
8 篇文章0 订阅
订阅专栏

云计算
13 篇文章0 订阅
订阅专栏
     在云计算中的数据存储方面，散列对提高查询效率起着很大的作用，散列函数是将字符串或者数字作为输入，通过计算输出一个整数，理想的散列函数输出非常均匀分布在可能的输出域，特别是当输入非常相似的时候。不同于加密散列函数，这些函数不是为防止攻击者找出碰撞而设计的。加密散列函数有这个特性但是要慢的多： SHA-1大约为0.09 bytes/cycle，而最新的非加密散列函数的速度大约为3 bytes/cycle。
     所以在不考虑抵御攻击的成本下，非加密散列大约要快33倍，非加密散列函数用的最多的地方是hash table。网络上提到散列的算法很多，资料纷杂，本文仅仅对各位博主的博文进行整合，旨在给大家一个清晰的关于散列函数的简要介绍。散列函数经历了多次改进，本文将改进分为三个阶段，并且给出了各个阶段的标志性算法的介绍和具体方法：

### 第一代：Bob Jenkins' Functions
​     Bob Jenkins在1997年他在《 Dr. Dobbs Journal》杂志上发表了一片关于散列函数的文章《A hash function for hash Table lookup》，这篇文章自从发表以后现在网上有更多的扩展内容。这篇文章中，Bob广泛收录了很多已有的散列函数，这其中也包括了他自己所谓的“lookup2”。随后在2006年，Bob发布了lookup3，由于它即快速（Bob自称，0.5 bytes/cycle）又无严重缺陷，在这篇文章中我把它认为是第一个“现代”散列函数。这里列出他的第一个版本的代码，其主要思想如下：

```c++
uint32_tjenkins_one_at_a_time_hash(unsigned char *key, size_t key_len){
    uint32_t hash = 0;
    size_t i;

    for (i = 0; i < key_len; i++) {
        hash += key;
        hash += (hash << 10);
        hash ^= (hash >> 6);
    }
    hash += (hash << 3);
    hash ^= (hash >> 11);
    hash += (hash << 15);
    return hash;
}
```

 而Thomas Wang在Jenkins的基础上，针对固定整数输入做了相应的Hash算法，其64位版本的 Hash算法如下：

       
``` cpp  
    uint64_thash(uint64_t key) {
        key = (~key) + (key << 21); // key = (key << 21) - key - 1;
        key = key ^ (key >> 24);
        key = (key + (key << 3)) + (key << 8); // key * 265
        key = key ^ (key >> 14);
        key = (key + (key << 2)) + (key << 4); // key * 21
        key = key ^ (key >> 28);
        key = key + (key << 31);
        return key;
    }
```  
     

总的来说，Jenkins很好的实现了散列的均匀分布，但是相对来说比较耗时，它有两个特性，1是具有雪崩性，既更改输入参数的任何一位都将带来一半以上的位发生变化，2是具有可逆性，但是在逆运算时，它非常耗时,如果想了解如何进行逆变换，请参考文献2.

### 第二代: MurmurHash
​     Austin Appleby在2008年发布了一个新的散列函数-MurmurHash。其最新版本大约是lookup3速度的2倍（大约为1byte/cycl e），它有32位和64位两个版本。32位版本只使用32位数学函数并给出一个32位的哈希值，而64位版本使用了64位的数学函数，并给出64位哈希值。根据Austin的分析，MurmurHash具有优异的性能，虽然Bob Jenkins 在《Dr. Dobbs article》杂志上声称“我预测[MurmurHash ]比起lookup3要弱，但是我不知道具体值，因为我还没测试过它”。MurmurHash能够迅速走红得益于其出色的速度和统计特性。MurMur的具体实现如下：

  
``` cpp
unsigned long long MurmurHash64B ( const void * key, int len, unsigned int seed ){
        const unsigned int m = 0x5bd1e995;
        const int r = 24;
        unsigned int h1 = seed ^ len;
        unsigned int h2 = 0;
        const unsigned int * data = (const unsigned int *)key;
    
    while(len >= 8){
        unsigned int k1 = *data++;
        k1 *= m; k1 ^= k1 >> r; k1 *= m;
        h1 *= m; h1 ^= k1;
        len -= 4;
    
        unsigned int k2 = *data++;
        k2 *= m; k2 ^= k2 >> r; k2 *= m;
        h2 *= m; h2 ^= k2;
        len -= 4;
    }
    
    if(len >= 4){
        unsigned int k1 = *data++;
        k1 *= m; k1 ^= k1 >> r; k1 *= m;
        h1 *= m; h1 ^= k1;
        len -= 4;
    }
    
    switch(len){
        case 3: h2 ^= ((unsigned char*)data)[2] << 16;
        case 2: h2 ^= ((unsigned char*)data)[1] << 8;
        case 1: h2 ^= ((unsigned char*)data)[0];
        h2 *= m;
    };
    
        h1 ^= h2 >> 18; h1 *= m;
        h2 ^= h1 >> 22; h2 *= m;
        h1 ^= h2 >> 17; h1 *= m;
        h2 ^= h1 >> 19; h2 *= m;
    
        unsigned long long h = h1;
        h = (h << 32) | h2; 
        return h;
}
```
       

MurMur经常用在分布式环境中，比如hadoop，其特点是高效快速，但是缺点是分布不是很均匀，这也可以理解，毕竟不能既让马儿跑，又让马儿不吃草...

### 第三代: CityHash 和 SpookyHash
​       2011年，发布了两个散列函数，相对于MurmurHash ，它们都进行了改善，这主要应归功于更高的指令级并行机制。Google发布了CityHash（由Geoff Pike 和Jyrki Alakuijala编写），Bob Jenkins发布了他自己的一个新散列函数SpookyHash（这样命名是因为它是在万圣节发布的）。它们都拥有2倍于MurmurHash的速度，但他们都只使用了64位数学函数而没有32位版本，并且CityHash的速度取决于CRC32 指令，目前为SSE 4.2（Intel Nehalem及以后版本）。SpookyHash给出128位输出，而CityHash有64位，128位以及256位的几个变种。由于两者的代码较长，这里给出源代码的连接如下：

SpookyHash开源代码http://burtleburtle.net/bob/hash/spooky.html  

cityhash 开源代码https://code.google.com/p/cityhash/    

## 散列函数哪家强？

文章中所提到的所有散列函数从统计学角度来看已经足够好。需要考虑的一个因素是CityHash/SpookyHash的输出超过了64位，但是对于一个32位的hash table来说这输出太多了。其他应用可能会用到128或256位输出。

如果你用的是32位机器，MurmurHash看起来是最明显的赢家，因为它是唯一一个快于lookup3的32位原生版本。32位机器很可能可以编译并运行City和Spooky，但我预计它们的运行速度和在64位机器上运行的速度比起来要慢的多，毕竟32位机器需要模拟64位的数学运算。在64位机器上，由于没有更深层次的基准，也很难说哪种算法是最好的。对比City我更倾向于Spooky，因为City的运行速度需要依赖于CRC32指令，毕竟这种环境并不是任何机器上都有的。 

另一个需要考虑的是对齐和非对齐的访问。Murmur散列（不像City或者Spooky）是一个仅能进行对齐读取的变种，因为在很多架构上非对齐的读取会崩溃或者返回错误的数据（非对齐的读取操作在C中是未定义的行为）。

City和Spooky都强调使用memcpy()把输入数据复制到对齐的存储结构中；Spooky使用一次memcpy()操作一个块（如果ALLOW_UNALIGNED_READS未定义），City使用一次memcpy()操作一个整型！在可以处理非对称读取的机器上（像x86和x86-64），memcpy将被优化，但我在我的小ARM上做了一个测试，发现如下：如果你需要32位或者仅仅是对齐读取的话，Murmur散列看起来依旧是最好的选择。

City散列和Spooky散列在x86-64上看起来更快，但我更倾向于认为它们是特定用于那个架构的，因为我不知道是否有其他既是64位又允许非对其读取的架构。

参考博文:
1 Hash 函数概览http://blog.csdn.net/zajin/article/details/12648587

2 [hash] Wang/Jenkins Hash http://wangjunle23.blog.163.com/blog/static/11783817120138863910800/

3 murmur:更快更好的哈希函数（字符串转64位hash值）  http://blog.csdn.net/wisage/article/details/7104866

————————————————
版权声明：本文为CSDN博主「Frank123721」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/zhaoyunxiang721/article/details/41087859