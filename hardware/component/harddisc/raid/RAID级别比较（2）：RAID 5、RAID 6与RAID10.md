# RAID级别比较（2）：RAID 5、RAID 6与RAID10

在之前的文章中，我们讨论了**[RAID 0](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.gntele.com%2Fnews%2Fcontent%2F232.html)**与RAID 1[之间的差异。我们这次将比较不同的RAID级别。您使用的RAID级别会影响您可以从RAID实现的确切速度和容错能力。您是否拥有硬件或](https://links.jianshu.com/go?to=http%3A%2F%2Fwww.gntele.com%2Fnews%2Fcontent%2F224.html)[**软件RAID**](https://links.jianshu.com/go?to=http%3A%2F%2Fwww.gntele.com%2Fnews%2Fcontent%2F224.html)也很重要，因为软件支持的级别低于基于硬件的RAID。有几种流行的RAID级别，包括RAID 0，RAID 1，RAID 5，RAID 6和RAID 10，让我们深入了解每个RAID级别。今天主要介绍RAID 5，RAID 6和RAID 10。

## 一、RAID 5

RAID 5需要使用至少3个驱动器，在RAID 0等多个驱动器上条带化数据，但在驱动器上分布有“奇偶校验”。如果单个驱动器发生故障，则使用存储在其他驱动器上的奇偶校验信息将数据拼凑在一起。停机时间为零。读取速度非常快，但由于必须计算奇偶校验，因此写入速度稍慢。它是具有有限数量的数据驱动器的文件和应用程序服务器的理想选择。

RAID 5占用了该奇偶校验的33％的存储空间（使用三个驱动器），但它仍然是比RAID 1更具成本效益的设置。最流行的RAID 5配置使用四个驱动器，将丢失的存储空间降低到25％ 。它最多可以与16个驱动器配合使用。

![img](https://upload-images.jianshu.io/upload_images/16933981-abb4defff3f04888.png?imageMogr2/auto-orient/strip|imageView2/2/w/682/format/webp)

## 二、RAID 6

RAID 6与RAID 5类似，但奇偶校验数据写入两个驱动器。这意味着它需要至少4个驱动器，并且可以承受同时死亡的2个驱动器。读取速度与RAID 5一样快，但由于必须计算额外的奇偶校验数据，因此写入速度比RAID 5慢。RAID 6是标准Web服务器的一个非常好的选择，其中大多数事务都是读取。但不建议用于繁重的写入环境，例如数据库服务器。

![img](https://upload-images.jianshu.io/upload_images/16933981-ebc9d19031d6ec37.png?imageMogr2/auto-orient/strip|imageView2/2/w/862/format/webp)

## 三、RAID 10

RAID 10至少包含四个驱动器，并将RAID 0和RAID 1的优势结合在一个系统中。它通过镜像辅助驱动器上的所有数据来提供安全性，同时在每组驱动器上使用条带化以加速数据传输。这意味着RAID 10可以提供RAID 0的速度和RAID 1的冗余。您可以丢失任何单个驱动器，甚至可能丢失第二个驱动器而不会丢失任何数据。就像RAID 1一样，只有总驱动器容量的一半可用，但您会看到改进的读写性能，并且还具有RAID 1的快速重建时间。与大型RAID 5或RAID 6阵列相比，这是一种昂贵的方式尽管有冗余。

![img](https://upload-images.jianshu.io/upload_images/16933981-32bcaf083906ad1e.png?imageMogr2/auto-orient/strip|imageView2/2/w/682/format/webp)

