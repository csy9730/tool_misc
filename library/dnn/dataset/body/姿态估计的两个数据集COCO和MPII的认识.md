## [姿态估计的两个数据集COCO和MPII的认识](https://www.cnblogs.com/caffeaoto/p/7793994.html)

|                  | COCO      数据集                                             | MPII数据集                                                   | Posetrack数据集                                              |
| ---------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 数据集格式       | [COCO数据集的标注格式](https://zhuanlan.zhihu.com/p/29393415) | 0 - r ankle, 1 - r knee, 2 - r hip,3 - l hip,4 - l knee, 5 - l ankle, 6 - l ankle， 7 - l ankle，8 - upper neck, 9 - head top,10 - r wrist,11 - r elbow, 12 - r shoulder, 13 - l shoulder,14 - l elbow, 15 - l wrist | 0 - r ankle, 1 - r knee, 2 - r hip,3 - l hip,4 - l knee, 5 - l ankle, 8 - upper neck, 9 - head top,10 - r wrist,11 - r elbow, 12 - r shoulder, 13 - l shoulder,14 - l elbow, 15 - l wrist |
| 关键点数量       | 17                                                           | 16                                                           | 14                                                           |
| 是否有mask       | 有                                                           | 无                                                           |                                                              |
| 评估标准         |                                                              |                                                              |                                                              |
| state of art算法 |                                                              |                                                              |                                                              |

目前主流的pose estimation方法：

pose-track和CPM的异同点：多了一个PAFs

目前存在的问题与常用解决思路：

现阶段有哪些大牛活跃在这个领域，并且目前的研究方向是什么：

------

------

 

**COCO数据集keypoint标注：**

　{0-nose    1-Leye    2-Reye    3-Lear    4Rear    5-Lsho    6-Rsho    7-Lelb    8-Relb    9-Lwri    10-Rwri    11-Lhip    12-Rhip    13-Lkne    14-Rkne    15-Lank    16-Rank}　``

但是在 ***openpose*** **训练时**，**转换成了如下顺序**：

　{0-'nose', 1-'neck', 2-'Rsho', 3-'Relb', 4-'Rwri',5-'Lsho', 6-'Lelb', 7-'Lwri', 8-'Rhip', 9-'Rkne', 10-'Rank', 11-'Lhip', 12-'Lkne', 13-'Lank', 14-'Leye', 15-'Reye', 16-'Lear', 17-'Rear', 18-'pt19'}

![img](https://images2017.cnblogs.com/blog/945479/201712/945479-20171216223955061-1066574044.png)

其中 1-‘neck' 是openpose增加的一个，也能认为是人体中心点。。但是18-'pt19' 是背景类，最后会被剔除

```
%%MATLAB code
s_vec = net.forward(input_data);
scores = cat(3, s_vec{2}(:,:,1:end-1), s_vec{1});
```

在Keypoint Annotations中，有个flag v 的定义：  v=0 ：没标记（x=y=0)  ||  v=1 : 标记了但不可见  ||  v=2 : 标记了且可见

↑参考：<http://blog.csdn.net/happyhorizion/article/details/77894205>

------

------

**MPII数据集标注：**

　　{ 0 - r ankle, 1 - r knee, 2 - r hip,3 - l hip,4 - l knee, 5 - l ankle, 6 - pelvis， 7 - thorax，8 - upper neck, 9 - head top,10 - r wrist,11 - r elbow, 12 - r shoulder, 13 - l shoulder,14 - l elbow, 15 - l wrist }

***openpose***在训练时，剔除了6 - pelvis（盆骨）， 7 - thorax（胸部）两个点，并增加了一个 center 点，共计输出是15个keypoint的heatmap和1个背景（要剔除）。

　　对应heatmap中的顺序为：{ 0-'nose', 1-'neck', 2-'Rsho', 3-'Relb', 4-'Rwri',5-'Lsho', 6-'Lelb', 7-'Lwri', 8-'Rhip', 9-'Rkne', 10-'Rank', 11-'Lhip', 12-'Lkne', 13-'Lank', 14-'center' }

 

**14-'center'** **这个点是由 2,3,12,13四个位置坐标取平均得到的！！！！！！！**

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
else if(np == 43){
    //int MPI_to_ours_1[15] = {9, 8,12,11,10,13,14,15, 2, 1, 0, 3, 4, 5, 7};
    //int MPI_to_ours_2[15] = {9, 8,12,11,10,13,14,15, 2, 1, 0, 3, 4, 5, 6};
    int MPI_to_ours_1[15] = {9, 8,12,11,10,13,14,15, 2, 1, 0, 3, 4, 5, 3};
    int MPI_to_ours_2[15] = {9, 8,12,11,10,13,14,15, 2, 1, 0, 3, 4, 5, 2};
    int MPI_to_ours_3[15] = {9, 8,12,11,10,13,14,15, 2, 1, 0, 3, 4, 5, 13};
    int MPI_to_ours_4[15] = {9, 8,12,11,10,13,14,15, 2, 1, 0, 3, 4, 5, 12};
    jo.joints.resize(np);
    jo.isVisible.resize(np);

    for(int i=0;i<15;i++){
//      jo.joints[i] = (j.joints[MPI_to_ours_1[i]] + j.joints[MPI_to_ours_2[i]]) * 0.5;
      jo.joints[i] = (j.joints[MPI_to_ours_1[i]] + j.joints[MPI_to_ours_2[i]]+j.joints[MPI_to_ours_3[i]] + j.joints[MPI_to_ours_4[i]]) * 0.25;
      if(j.isVisible[MPI_to_ours_1[i]]==2 || j.isVisible[MPI_to_ours_2[i]]==2){
        jo.isVisible[i] = 2;
      }
      else {
        jo.isVisible[i] = j.isVisible[MPI_to_ours_1[i]] && j.isVisible[MPI_to_ours_2[i]];
      }
    }
  }
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

 

 

------

------

 

center map 是什么：

![img](https://images2017.cnblogs.com/blog/945479/201712/945479-20171213165404269-990911143.png)

center map（绿色）是一个提前生成的高斯函数模板，用来把响应归拢到图像中心。长这样： 

![img](https://images2017.cnblogs.com/blog/945479/201712/945479-20171213165431754-1411475791.png)



标签: [数据集](https://www.cnblogs.com/caffeaoto/tag/数据集/), [pose estimation](https://www.cnblogs.com/caffeaoto/tag/pose estimation/)