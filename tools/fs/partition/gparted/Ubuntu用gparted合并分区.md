# [Ubuntu用gparted合并分区](https://www.cnblogs.com/pengdonglin137/articles/4197946.html)

转载：http://www.linuxidc.com/Linux/2010-06/26689.htm

​    

​    在使用Linux的过程中，随着软件的安装和数据的膨胀，有时候会发现划分给Linux分区需要进行调整。如果直接使用分区命令fdisk调整分区大小，往往意味着分区数据的丢失。LVM技术可以避免分区数据丢失，但在使用中有许多限制。本文介绍一种使用gparted进行Linux分区调整的方法，它比较适合个人计算机中的硬盘分区调整，同时也可避免数据丢失。

gparted是一款免费、开源的Linux下的具有图形用户界面的分区软件。

在Ubuntu中，可以使用如下命令安装：

**sudo apt-get install gparted**

注意，在Ubuntu中，gparted在默认情况下并不支持NTFS分区，必须还要使用如下指令安装ntfsprogs:

**sudo apt-get install ntfsprogs**

之后就可以使用如下命令启动gparted:

**sudo gparted**

 

本文重点讨论在[Ubuntu](http://www.linuxidc.com/topicnews.aspx?tid=2)下使用gparted工具对分区进行扩容或合并。主要针对某一分区不够用的情况。将某个分区缩小，没有什么大问题。

  分区是安装操作系统的第一步，但在操作系统之前，我们很难清楚地知道哪些分区需要多大的空间，就算从其他人那里获得一些提醒和参考数字，但针对自己的具体 情况，往往还是有出入的。有些分区比需要的大些，没有多大问题，只要你的硬盘足够用。但如果有些分区用完了，不够用的，麻烦了！

  这个时候，就不得不调整分区的大小。有很多方式。有的直接删除系统，重新分区，然后再重装操作系统，干脆、麻烦由累人，而且要求大量的备份或根本就没有重 要的东西要备份；有的把大的分区划出一块空闲的空间，把小的空间也删掉，空闲分区和在一起，然后重新建立分区，在linux下还要修改fstab文件，不 但要提防数据丢失还要的清楚地知道fstab是怎么回事，所以你对于linux需要有一定的水平；当然也有的用逻辑卷的方法。总之，无论采用什么方法，都 要进行必要的备份，保证万无一失。

我的磁盘上已经有了一个空闲的空间，需要将这个空闲的分区合并到那个较小的分区中去。到网上查了一下，主要是两种方法，就是逻辑卷，还有删除分区重 建分区 再修改fstab的方法，我觉得既然有了专门的工具，怎么可能还要如此麻烦呢？！如果这样，工具gparted存在的价值就值得怀疑了。

  我想很多人之所以要这样做，是因为没有很好的了解gparted 的用法。

  首先需要注意的一点是：gparted中对一个分区的操作，只能影响到最邻近的两个其他分区，也只有邻近的这两个分区能影响到该分区。

  即，如果一个分区划出一小块出来，成了空闲区，那么该空闲区生成后肯定临着该分区。自然，如果一个分区要扩大，就必须保证这个分区的上下两个区有一个是空 间的，未分配的。只有这样才可以对该分区进行扩容调整！在gparted中，一个分区要扩大，需要的前后空闲区的大小至少有一个不为0。

   我的磁盘上的空闲区和小分区并不相邻。所以需要将空间区挪到小分区附近。具体见后面的图1。如果挪动分区呢，就我目前的了解，只能把要“路过”的分区一一 进行调整。（注意，调整的不是这些路过分区的大小，而是其前后的空闲区的大小，见图2）。比如，将"unallocated"挪到/dev/sda9上 面，就需要经过/dev/sda6, /dev/sda7, /dev/sda8这三个要路过的分区。需要分别调整这些分区的前后空闲区的大小。

  对于/dev/sda6,选中后，点击按钮“Resize/Move”，出现图2中的对话框，有三个编辑框，分别是：Free Space Preceding, New Size, Free Space following.我们要做的是调整第一个和第三个值。在图1和图2中，可以看到，"unallocated"大小为 11.37GB（11641MB），它在/dev/sda6的紧上方，而/dev/sda6后面没有其他的空闲区了，所以，在“Resize/Move” 对话框中，Free Space Preceding为11641MB，而Free Space following为0MB。

为了把空闲区往下挪，挪到/dev/sda6的紧下面（离/dev/sda9更近），只要把/dev/sda6的Free Space Preceding设为0，而Free Space following设为空闲区的大小。当然，如果不是要把整个空闲都挪动，这个值可以设定为你需要的小些的值。如果需要整个挪动，有个技巧，就是只把 Free Space Preceding设为0即可，系统会自动把Free Space following设置为需要的值（整个空闲区的大小），当然要实时看到结果，只要鼠标重新定位一下即可（在别的地方点一下，比如在Free Space following的输入框）。设置的情况，见图3。然后点击对话框中的“Resize/Move”按钮，就可以看到图4的效果了。再点“Apply”， 就开始了分区位置调整的处理，实现图4的设置。（当然，可以把所有的操作和最终的效果设置好，再apply）

   这样，一步步，一次对 /dev/sda7, /dev/sda8做同样的处理，就可以把空闲区挪到/dev/sda9的紧上方。再对/dev/sda9进行“Resize/Move”，就会发现，该 分区的前后空闲区的大小已经不是都为0了，它的前面空闲区已经是11641MB了，这样，就可以对/dev/sda9进行扩容了。

​    需要注意的一个问题是：如果调整时，涉及了swap分区，需要先禁止它。但调整之后发现，重启后swap没有挂载激活，导致系统很慢，需要激活swap。 细看一下是该swap分区的uuid变了，需要在fstab中改一下。我想这是gparted的不完善之处。

​    查看分区的UUID： ls -l /dev/disk/by-uuid

列出分区的情况：df -lh

![img](https://images0.cnblogs.com/blog/480488/201501/012300009975182.jpg)

 图1. 我的磁盘分区情况，需要将"unallocated"中的1G合并到分区/dev/sda9中去。

 ![img](https://images0.cnblogs.com/blog/480488/201501/012302575916765.jpg)

图2. 在gparted中，每个分区都有三个属性可以调整。

 

![img](https://images0.cnblogs.com/blog/480488/201501/012303358726436.jpg)

图3. 将空闲区挪到下方。（**可以直接用鼠标拖动对话框中的左右箭头来调整分区大小**）

 

![img](https://images0.cnblogs.com/blog/480488/201501/012304033094486.jpg)

图4. 设定的分区位置的调整效果。

 

 

分类: [Linux 发行版](https://www.cnblogs.com/pengdonglin137/category/708683.html)

标签: [Ubuntu](https://www.cnblogs.com/pengdonglin137/tag/Ubuntu/)