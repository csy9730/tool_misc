# Lerp

1、Lerp
线性插值计算、匀速移动
2、LerpAngle
线性插值计算、匀速旋转
3、MoveTowards 
4、MoveTowardsAngel 
5、SmoothStep非匀速移动 
6、SmoothDamp和SmoothDampAngel带有阻尼系数的移动，减速运动 
7、四元数Quaternion：Gameobject.transform.rotation就是一个Quaternion。
旋转是有顺序的，三维空间和物体自身角度？万向锁 
8、mathf.Lerp和Vector3.Lerp、Quaternion.Lerp的区别
mathf.Lerp一维方向上的移动
Vector3.Lerp三维空间的移动
Quaternion.Lerp在物体的两个自身角度之间旋转
9、repeat和pingpong
repeat一维数据区间重复，举例：1-3,1-3
pingpong一维数据区间往复，举例：1-3-1-3-1
10、循环曲线：
GammaToLinearSpace VS LinearToGammaSpace 相互转换 + Mathf.PerlinNoise 噪声图
11、四元数相乘改变角度
效果同rotate方法
12、rotation和localrotation的区别
13、rigbody的各种力
按世界坐标系的
按自身坐标的
旋转力addtorque
14、向某一坐标点的力
AddForceAtPosition
15、爆炸力
AddExplosionForce
参数为：爆炸点和影响半径