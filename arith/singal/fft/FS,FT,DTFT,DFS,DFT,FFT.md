# FS,FT,DTFT,DFS,DFT,FFT

- FS Fourier series 傅里叶级数
- FT Fourier transform 傅里叶变换
- DTFT = Discrete Time Fourier transform = 离散时间傅里叶变换
- DFS = Discrete Fourier series = 离散傅里叶级数
- DFT = Discrete Fourier transform = 离散傅里叶变换

- CFS 作用的对象是无限长连续周期序列
- FT 作用的对象是连续非周期
- DTFT 作用的对象也是有限长连续非周期信号。
- DFS 作用的对象是无限长离散时间周期序列
- DFT 作用的对象是有限长离散时间非周期信号

- CFS 的结果是频域上的离散非周期信号
- DTFT 的结果是频域上的连续周期信号。
- DFS 的结果是频域上的离散周期信号
- DFT 的结果也是频域上的离散周期信号

																				
### FS

$$
\int_{-T/2}^{T/2}{|x(t)|^2dt}<\infin
$$

傅里叶系数，范围是-inf,inf
$$
X(k\Omega_0)=\frac{1}{T}\int_{-T/2}^{T/2}{x(t)e^{-jk\Omega_0t}dt}
$$


$$
x(t)=\sum_{k=-\infin}^{\infin}{X(k\Omega_0)e^{jk\Omega_0t}}
$$


- 输入：连续周期
- 输出：离散非周期

### FT
$$
X(j\Omega)=\int_{-\infin}^{\infin}{x(t)e^{-j\Omega t}dt}
$$
逆变换
$$
x(t)=\frac{1}{2\pi}\int_{-\infin}^{\infin}{X(j\Omega)e^{j\Omega t}d\Omega}
$$

- 输入：连续非周期
- 输出：连续非周期

### DTFT
$$
X(e^{j\omega})=\sum_{n=-\infin}^{\infin}{x(n)e^{-j\omega n}}
$$

逆变换
$$
x(n)=\frac{1}{2\pi}\int_{-\pi}^{\pi}{X(e^{j\omega})e^{j\omega n}d\omega}
$$

- 输入：离散非周期
- 输出：连续周期

FS 和 DTFT对偶


### DFS
$$
X(k)=\sum_{n=0}^{N-1}{x(n)e^{-j\frac{2\pi}{N}nk}}
$$
逆变换
$$
x(n)=\frac{1}{N}\sum_{k=0}^{N-1}{X(k)e^{j\frac{2\pi}{N}nk}}
$$

- 输入：离散周期
- 输出：离散周期


### DFT

$$
X(k)=\sum_{n=0}^{N-1}{x(n)e^{-j\frac{2\pi}{N}nk}}=\sum_{n=0}^{N-1}{x(n)W_N^{nk}}
$$
逆变换
$$
x(n)=\frac{1}{N}\sum_{k=0}^{N-1}{X(k)e^{j\frac{2\pi}{N}nk}}=\frac{1}{N}\sum_{k=0}^{N-1}{X(k)W_N^{-nk}}
$$

2
$$
W_N=exp(-j\frac{2\pi}{N})
$$
### 对偶

- 时域周期对应频域的离散点
- 时域非周期对应频域的连续点
- 时域离散对应频域的周期
- 时域连续对应频域的非周期


### FFT
DFT与FFT其实是一个本质，FFT是DFT的一种快速算法。

