# filter

## 滤波器分类

- 低/高分类
  - 低通滤波器 LowPass
  - 高通滤波器 HighPass
  - 带通滤波器 BandPass
  - 带阻滤波器 Band Stop
- 数字/模拟
  - 数字滤波器
  - 模拟滤波器
- 离散/连续变换
  - c2d
    - 冲击响应不变法
    - 双线性z变换
  - d2c
- FIR/IIR
  - FIR
  - IIR
      - Buttorworth
      - Chebyshev-I
      - Chebyshev-II
      - 椭圆滤波器
- 最小/最大相位系统
  - 最小相位系统
  - 混合相位系统
  - 最大相位系统
- 特殊滤波器
  - 全通系统
  - 线性相位
    - 线性相位FIR
      - h(n) =h(N-1-n), N=2k
      - h(n) =h(N-1-n), N=2k+1 （N取奇数略好于偶数）
      - h(n) =-h(N-1-n), N=2k 类似差分器
      - h(n) =-h(N-1-n), N=2k+1 类似差分器
  - 零相频响应系统
  - filtfilt 二重滤波 （可以实现零相位滤波）

