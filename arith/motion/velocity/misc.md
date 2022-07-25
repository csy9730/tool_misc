# misc

能否达到匀速
- 长线段前瞻， S50,S61,S62,S70. 速度范围大，
- 短线段前瞻，速度范围小。

### 融合
- 长线段融合
    - vmax == vseg 可以融合
    - vmax > vseg 无法融合
- 短线段融合
    - vpre < vseg, vpro < vseg
        - v0 < vpre < vpro < v1 
            - 可以融合 v0 < vpre_s23p < vpro_s24p < v1 
            - 无法融合
        - v0 > vpre , vpro > v1
            - 可以融合 v0 < vpre_s25n , vpro_s26n < v1 
            - 无法融合
    - vpre > vseg, vpro > vseg
- 长短线段融合




左右树选择
- 首次分割树时，选择结点最小的分割，（就是避免两颗子树的节点值接近）
- 优先计算最小结点树的限速
- 根据限速来判断另一边的限速是否符合。

### Marlin

https://github.com/MarlinFirmware/Marlin

### S-curve-Velocity-Profile
https://github.com/Larissa1990/S-curve-Velocity-Profile

#### Optimize_S-Curve_Velocity_for_Motion_Control
[https://www.researchgate.net/publication/257576837_Optimize_S-Curve_Velocity_for_Motion_Control](https://www.researchgate.net/publication/257576837_Optimize_S-Curve_Velocity_for_Motion_Control)

#### Look-Ahead_Algorithm_with_Whole_S-Curve_Acceleration_and_Deceleration
https://www.researchgate.net/publication/258401146_Look-Ahead_Algorithm_with_Whole_S-Curve_Acceleration_and_Deceleration

#### A dissymmetrical s curve velocity plan & look-ahead algorithm for small line segments
A dissymmetrical s curve velocity plan & look-ahead algorithm for small line segments
Mei Xuesong
Published 2010
Engineering
Machinery Design and Manufacture

https://www.semanticscholar.org/paper/A-dissymmetrical-s-curve-velocity-plan-%26-look-ahead-Xuesong/1b01f0ffd7dd66f37583b78bcd442a09f3d09d56#paper-header

#### Research on S Type Acceleration and Deceleration Time Planning Algorithm with Beginning and End Speed Non-zero
Research on S Type Acceleration and Deceleration Time Planning Algorithm with Beginning and End Speed Non-zero
Liangliang Yang
Published 2016
Physics, Computer Science
Journal of Mechanical Engineering
： To solve the problem of planning acceleration and deceleration time of the asymmetric S type speed curve with the beginning and the end speed non zero, acceleration curve is divided into seven time segments and speed and displacement equations are obtained. Construct square function which has argument of derivative of acceleration and the convex feature according to the monotonic change of simplified high order equation transformed from speed and displacement equations. The time segment of derivative of acceleration is obtained by the Newton Iterative and then modified by the principle of efficiency optimization and speed and acceleration limitations. The time segment of acceleration is obtained by solving quadratic equation in one variable and also modified by principle of efficiency optimization and speed and acceleration limitation. And at last the time segment of constant speed is obtained by solving one order equation in one variable. This algorithm solves the problem of the complexity of traditional planning of asymmetric S type acceleration and deceleration time and provides a simple, efficient acceleration and deceleration time planning algorithm. Through simulation and experiment, the efficiency of this algorithm is increased by 10.8%, the interpolation efficiency is increased by 3.39%, and the interpolation accuracy meets the requirements and the algorithm is proved to be simple, efficient and meets the requirements of CNC with high speed and high precision. 
