# 海思MPP：海思的图像内存管理

[我是小北挖哈哈](https://www.zhihu.com/people/wo-shi-xiao-bei-wa-ha-ha)

不想做运维的测试不是好开发



16 人赞同了该文章

**写在前面**

《海思MPP》系列文章发表之后，通过知乎平台认识了不少也在海思芯片上开发的同学，大家互相交流了很多技术细节，笔者发现在了解“怎么用海思MPP做xxx”之前，有一个必须知道的知识点：海思MPP的图像内存管理。 本文将分享以下两块内容：

1. 笔者对于海思MPP的MMZ和VB的认识
2. 怎么在MMZ和VB上读写图像

### **I. MPP和VB的介绍**

关于MPP和VB的概念，笔者在《海思MPP》系列开篇中就介绍过，这里再次强调下OS MEM，MPP和VB的概念：

- **海思的OS MEM（Operating System Memory，系统内存）**：同Linux，Windows等系统的内存，一般是和CPU计算单元在一张主板上的RAM区域。
- **海思的MMZ（Media Memory Zone，多媒体内存区域）\***：海思专有内存，由MMZ驱动模块进行管理供媒体业务单独使用的内存。在海思SoC上，MMZ内存和OS MEM是统一物理介质。插一句：海思芯片上可以通过工具划分MMZ和OS MEM的占比，不过一旦划分好之后就确定下来了，运行时不可以再修改。
- **VB（Video Buffer，视频缓存池）**：海思MPP专用于视频数据的传输和存储，属于MMZ。

也就是说：从物理结构上来看，OS MEM、MMZ和VB是一样的；但是在应用上来看，OS MEM则是用于CPU计算单元使用的，MMZ则是供海思各个模块使用的，而VB应该仅海思MPP使用；从管理使用上来看，OS MEM和MMZ的设计理念一致，用户可以随时申请、释放，而VB则有专门的管理机制。

而对于海思开发者们而言，熟悉和掌握MMZ是非常重要的。

### **MMZ调试**

- `cat /proc/media-mem`：查看到系统总共、已使用的、剩余的MMZ，包括每一块已经使用的MMZ的使用情况。这个类似于Linux中调用`free`来查看系统的OS内存情况。

### **MMZ使用**

海思MPP提供了一套MMZ的API接口，包括MMZ申请、释放、物理地址和虚拟地址的映射等。笔者认为在程序中使用MMZ有2个地方必须掌握：地址（虚拟地址vs物理地址）和缓存（可缓存vs不可缓存）

**地址（虚拟地址vs物理地址）**

海思提供了虚拟地址和物理地址之间互相映射的API，这也可见MMZ虚拟地址和物理地址两者的重要性，那么编程中需要注意什么呢？

- 物理地址：实际拿到的海思地址，在海思中只有一些模块能够直接访问物理地址（CPU不能访问），一般用于硬件加速、不同进程间地址交换；
- 虚拟地址：在本程序的地址页表上的地址，就如同OS MEM一样使用即可，也就是说CPU可以直接访问。如果要在不同进程间交换，需要考虑使用共享内存等机制。

**缓存（可缓存vs不可缓存）**

这里的“缓存”是指，MMZ的虚拟地址会被CPU的寄存器缓存。

- 可缓存：MMZ虚拟地址会被CPU的寄存器同步保存一份，以做缓存命中，因此可缓存的MMZ会极大提高程序的读写性能；但是一定记住在外部模块需要读写该MMZ之前要调用flush接口做同步。
- 不可缓存：不会被CPU的寄存器保存，也就是每次CPU读写该MMZ时都必然是和内存做读写，可以想见性能必然不高；但是这样的好处是编程人员不需要考虑一致性问题，不需要做flush。

还有一点必须记住，程序必须及时调用**HI_MPI_SYS_MmzFree**释放掉不用的MMZ，海思系统并不会帮助回收程序申请的MMZ内存。

### **II. 读写图像数据**

因为一般都是用MMZ和VB处理视频数据，因此常常打交道的是YUV格式图片。在介绍怎么用MMZ和VB读写图片之前，需要介绍YUV。 YUV格式有很多，就存储的数据内容而言，可以分为：YUV444（全格式，UV分量无损耗），YUV422和YUV420（常见格式）；就YUV420而言，Y/U/V三个分量的组织形式不同，可以分为planner（平面格式），packet（大包格式）和semi-packet（半包格式）。更多分为和内容，欢迎阅读我之前的文章《xxx》

海思上接触到更多的应该是**YUV420SP**，也就是YUV420下的semi-packet。这种格式的存组织数据格式是：**先存放Y分量，接着UV分量相邻存放**。如下图（图片引用于[AOE工程实践-银行卡OCR里的图像处理](https://www.cnblogs.com/puhuichanpin/p/11466058.html)）：

![img](https://pic3.zhimg.com/80/v2-ca2666d18afda97f2fa158ff914008f2_720w.jpg)YUV420SP

除了颜色空间和颜色格式之外，在使用海思MMZ的时候有一个非常重要的概念必须了解：**stride（跨距）**。跨距是什么呢？其实就是MMZ真实的宽度！也就是说，真实的图像，假设有长宽为h*w，而我们申请的MMZ尺寸为长和跨距为h*s，这里必然有s>=w！看了下面的示意图应该能够更清晰：

![img](https://pic1.zhimg.com/80/v2-5bffb42c3c9a93c6e765e8f851d598e0_720w.jpg)

问题来了：**是否可以申请跨距和图像宽度相同的MMZ，这样子实际操作的时候跨度就是宽度了？**

答案是：**不一定。**因为海思很多模块和操作对MMZ的跨距有对齐要求（不同平台要求不一致，请自行阅读官方文档），比如要求16对齐，那么"44（宽度）x96（长度）"的图像就必须申请"48（跨距）x96（长度）"的MMZ。

又一个问题来了**：平时在用ffmpeg或者opencv等工具读写图像数据时，并没有stride这样的信息，只需要关注长宽即可，这个是为什么呢？**

答案：**CPU底层自动做了对齐，导致上层用户无感知。**

正是由于MMZ的跨距的存在，因此在读写图像时，就不能够直接调用`fwrite(addr, w*h*1.5, ...)`完事，而是需要按照stride为真实宽度，每次保存图像宽度width。伪代码如下：

```text
  FILE* fout = fopen(filename, "wb");
  for (int i = 0; i < height * 1.5; ++i) {
    fwrite(pVirAddr + stride * i, 1, width, fout);
  }
  fclose(fout);
```

对于VB而言也是一样的，只不用户在操作MMZ时，其实是直接操作一整块内存，只有一个虚拟地址或者物理地址；而VB虽说也是MMZ，但是海思很多结构封装了VB，比如`VIDEO_FRAME_INFO_S`结构，其子结构`stVFrame`的属性/字段`u64VirAddr`就是VB，但是这是一个数组变量，每一个维度对应的是Y/U/V的每一个分量。如上文谈到YUV所述，在海思中经常接触到YUV420SP结构，很自然的，`u64VirAddr[0]`就是Y分量，那么U/V怎么存储呢？`u64VirAddr[1]`和`u64VirAddr[2]`内容一样，都保存了UV分量（这点还不可查，也可能是`u64VirAddr[2]`内容为空，但是`u64VirAddr[1]`一定存储了UV分量）。其伪代码如下：

```text
  FILE* fout = fopen(filename, "wb");
  for (int i = 0; i < frameInfo.stVFrame.u32Height; ++i) {
    fwrite(frameInfo.stVFrame.u64VirAddr[0] + i * frameInfo.stVFrame.u32Stride[0], 1,
                       frameInfo.stVFrame.u32Width, fout);
  }
  for (int i = 0; i < frameInfo.stVFrame.u32Height / 2; ++i) {
    fwrite(frameInfo.stVFrame.u64VirAddr[1] + i * frameInfo.stVFrame.u32Stride[1], 1,
                       frameInfo.stVFrame.u32Width, fout);
  }
  fclose(fout);
```

以上伪代码可见笔者个人github仓库：[rapidcv_mpp](https://github.com/ooooona/rapidcv_mpp/blob/master/src/rapidcv_mpp/common.cpp)。

### **写在后面**

如果文中有任何不正确的问题，欢迎指正。此外，也欢迎交流讨论任何视频媒体、边缘计算相关的问题~



发布于 2020-10-02

海思芯片

视频技术

华为海思

赞同 16