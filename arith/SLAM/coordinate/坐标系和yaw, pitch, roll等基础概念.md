# 坐标系和yaw, pitch, roll等基础概念

[Z-HE](https://www.zhihu.com/people/Z-HE1)


12 人赞同了该文章

## 坐标系

右手坐标系：把右手拇指食指中指伸直并正交，拇指X，食指Y，中指Z。一般无特殊说明，都是右手坐标系。

右手坐标系的旋转正方向：从轴的正方向看向原点，逆时针方向即是旋转正向。或者，伸出右手，拇指指向旋转轴正向，四指弯曲，四指指向的旋转方向就是正向。

世界坐标系之NED坐标：X轴向北，Y轴向东，Z轴向下

世界坐标系之ENU坐标：X轴向东，Y轴向北，Z轴向上

世界坐标系之NWU坐标：X轴向北，Y轴向西，Z轴向上（这个坐标系最符合人类想象）

自身坐标系之FRD坐标：X轴向前，Y轴向右，Z轴向下。

自身坐标系之FLU坐标：X轴向前，Y轴向左，Z轴向上。（这个坐标系最符合人类想象）

FRD和NED配合：当自身面北平放的时候，FRD坐标系和NED坐标系重合。

FLU和ENU配合：当自身面东平放的时候，FLU坐标系和ENU坐标系重合。

FLU和NWU配合：当自身面北平放的时候，FLU坐标系和NWU坐标系重合。（最佳配合）

建议：当做一个系统的时候，要先统一系统内部的坐标系，优先统一到FLU+NWU。输入的坐标，在输入的时候，就要转为内部坐标系；输出的坐标，在输出的时候，根据用户的要求转为相应的外部坐标系。



## yaw, pitch, roll

~~以头部运动为例：yaw是摇头，pitch是点头，roll是摆头。~~

### yaw
yaw：偏航角。是沿世界坐标系的Z轴旋转的角度。0表示面向世界坐标系的X轴正向。

在NED坐标下，0度是面向正北。在ENU做坐标下，0度是面向正东。

面向正北，在NED下，是0度，在ENU下，则是PI/2弧度。

面向正北偏东1度(0.01745弧度)，在NED坐标系下，yaw=0.01745，在ENU坐标系中，yaw=PI/2-0.01745

所以，可以推算出来，yaw从END坐标系转到ENU坐标系的转换公式为：yaw_ENU = PI/2 - yaw_END

### pitch
pitch：俯仰角。就是抬头或低头，和大地水平面的夹角。换句话说，是沿自身坐标系（X轴向前的坐标系）的Y轴旋转的角度。

抬头1度，在FRD坐标系下，pitch=0.01745，在FLU坐标系中，pitch=-0.01745。

所以，可以推算出来，pitch从FRD坐标系转到FLU坐标系的转换公式为：pitch_FLU = - pitch_FRD

### roll
roll：翻滚角。就是左倾或右倾，和大地水平面的夹角。换句话说，是沿自身坐标系（X轴向前的坐标系）的X轴旋转的角度。

右倾1度，在FRD坐标系下，roll=0.01745，在FLU坐标系中，roll=0.01745。

所以，可以推算出来，roll从FRD坐标系转到FLU坐标系的转换公式为：roll_FLU = - roll_FRD

注意，不同的惯导设备，采用的坐标系是不同的，有的用FRD，有的用FLU。例如ROS就缺省使用FLU，如果需要将某个FRD设备的数据发布到ROS，就需要做一个转换。



## 欧拉角

参考 [马同学：如何通俗地解释欧拉角？之后为何要引入四元数？](https://www.zhihu.com/question/47736315/answer/236284413)

用3次连续转角来描述2个坐标系之间的旋转关系。

设xyz 为全局坐标，保持不动

设XYZ 为局部坐标，随着物体一起运动

那么zXZ的欧拉角为：

1) 物体绕全局的 z 轴旋转 alpha 角

2) 继续绕自己的 X 轴旋转 beta 角

3) 最后绕自己的 Z 轴旋转 gamma 角



### Z-Y-X欧拉角

参考 Introduction to Robotics Machanics and Control.pdf P43

ZYX欧拉角是yaw-pitch-roll次序。

1) 先沿着Z轴旋转一个yaw角

2) 再沿着自己的Y轴旋转一个pitch角

3) 再沿着自己的X轴旋转一个roll角

设R为3*3的旋转矩阵，则R = R_yaw * R_pitch * R_roll

R_yaw是旋转后z不变的阵，R_pitch是旋转后y不变的阵，R_roll是旋转后x不变的阵。



### 求一个点在另一个坐标系中的坐标

参考 Introduction to Robotics Machanics and Control.pdf P27 Mappings involving general frames 公式2.19

设有2个坐标系 A 和 B，现在有一个点P，它在B坐标系中的坐标是P_b，那么求它在A坐标系中的坐标P_a。

已知B的原点在A坐标系中的坐标是O_ba，已知B相对于A的旋转矩阵是R_ab。

那么，我们可以先保持B的原点不动，把B旋转为B1，和A同向。此时该点P的坐标在B1里面是P_b1。而P_a = P_b1 + O_ba。

所以有 `P_a = R_ab P_b + O_ba`（2.17)

以上的公式，可以写成更酷的一个公式：
```
[P_a, 1]T = T_ab [P_b, 1] (2.19)
```
其中，T_ab为1个4*4的矩阵，左上角是R_ab，右上角是O_ba，左下角是 0 0 0，右下角是1。



## 四元数用于旋转

参考 [彻底搞懂四元数 - 前路漫漫的博客 - CSDN博客](https://blog.csdn.net/shenshen211/article/details/78492055)

四元数有x,y,z,w这4个分量。错误的理解是：x,y,z表示旋转轴，w表示旋转角度。但实际上，如果ax,ay,az是旋转轴向量，theta是旋转角度的话，四元数实际是：
```
w = cos(theta/2)
x = ax * sin(theta/2)
y = ay * sin(theta/2)
z = az * sin(theta/2)
```

这样定义很不直观，但好处是可以可以插值。

给定两个四元数p和q，分别代表旋转P和Q，则乘积pq表示两个旋转的合成（即旋转了Q之后再旋转P）

举个例子，我们要把一个enu的航向角yaw，转成nwu的yaw，就可以直接用一个表示旋转的四元数乘它既可：

``` cpp
tf::Quanterion enu2nwu;

enu2nwu.setRPY(0, 0, -M_PI_2); // 以目标坐标nwu为基准，看源坐标enu在目标坐标中，是沿z轴正方向旋转了-PI/2。

yaw_nwu = enu2nwu * yaw_enu; // yaw本身表示一个旋转，左边乘以enu2nwu，表示先旋转坐标系得到新的坐标系，然后再旋转本身。

```



编辑于 2018-12-17

机器人操作平台 (ROS)