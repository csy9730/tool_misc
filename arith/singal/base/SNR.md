# SNR 


## base

ADC AC Measurement
- SNR
- THD
- 
### 谐波
对周期交流量进行频域分解，得到频率不等于基波频率整数倍的分量。 [4] 
——引自DL/T1198—2013《电力系统电能质量技术管理规定》

交流非正弦信号可以分解为不同频率的正弦分量的线性组合。当正弦波分量的频率与原交流信号的频率相同时，称为**基波**；当正弦波分量的频率是原交流信号的频率的整数倍时，称为**谐波**；当正弦波分量的频率是原交流信号的频率的非整数倍时，称为分数谐波，也称分数次谐波或**间谐波**。

### 噪声

### 信号混杂成分
- 基波信号
- 谐波失真
- 随机噪声 电器设备随机波动
- 干扰 环境或其他设备引起
- 哼鸣 供电电源引起

###  SNR
信噪比
> Signal to noise ratio or SNR is the ratio of the RMS signal amplitude to the mean value of the root-sum-squares of all other spectral components, excluding the DC and first five harmonics.

$$
SNR = 10log_{10}\frac{S}{N}
$$

信噪比(SNR，有时也称为无谐波的SNR)与SINAD一样，也是根据FFT数据计算，不同的是计算剔除了信号谐波，仅留下噪声项。实际应用中，只需剔除主要的前5次谐波。SNR性能在高输入频率下会下降，但由于不包括谐波项，其下降速度一般不像SINAD那样快。

### THD

THD是英文Total Harmonic Distortion的缩写，意为总谐波失真。 　

谐波失真是指音箱在工作过程中，由于会产生谐振现象而导致音箱重放声音时出现失真。尽管音箱中只有基频信号才是声音的原始信号，但由于不可避免地会出现谐振现象（在原始声波的基础上生成二次、三次甚至多次谐波），这样在声音信号中不再只有基频信号，而是还包括由谐波及其倍频成分，这些倍频信号将导致音箱放音时产生失真。对于普通音箱允许一定谐波信号成分存在，但必须是以对声音基频信号输出不产生大的影响为前提条件。

而总谐波失真是指用信号源输入时，输出信号（谐波及其倍频成分）比输入信号多出的额外谐波成分，通常用百分数来表示。一般说来，1000Hz频率处的总谐波失真最小，因此不少产品均以该频率的失真作为它的指标。所以测试总谐波失真时，是发出1000Hz的声音来检测，这一个值越小越好。

#### 定义公式1
$$
THD=\sqrt{\sum_2^H{(\frac{G_i}{G_1})^2}}
$$
按照上述定义，THD不包含间谐波，并且，有一固定的谐波上限。

符号G表示谐波分量的有效值，它将按要求在表示电流时被I代替，在表示电压时被U代替，H的值在与限制有关的每一个标准中给出。按照上述定义，THD不包含简谐波，并且，有一固定的谐波上限。
#### 定义公式2
$$
THD = \sqrt{\frac{Q^2-Q_1^2}{Q_1}}
$$
Q为总有效值，Q1为基波有效值，可代表电压或电流

THD包含间谐波和直流分量。


### THD+N
目前最常用的失真测量方法是总谐波失真加噪声（THD+N[noise]）技术。 在音频设备中，除了电子元器件的非线性导致的谐波失真， 还有器件的噪声造成的影响，通常用THD+N表示。 THD+N是英文Total Hormonic Distorion + Noise的缩写，翻译成“总谐波失真加噪声”。它是音频设备的一个重要性能指标。


THD+N 测量失真的基本原理：使用陷波滤波器滤除基波，再用带限滤波器。

> The THD+N technique is the most common method of measuring harmonic distortion. In its basic form, it is implemented with a sharp notch filter tuned to the fundamental sine frequency, a bandwidth limiting filter, and an rms level meter . The notch filter and bandwidth limiting filter can also be realized with FFT analysis. The notch filter removes the fundamental sine signal, leaving a residual signal which consists of the harmonics and noise. The THD+N Ratio is calculated as the bandwidth limited rms level of the residual divided by the rms level of the entire signal.

### 无杂散动态范围(SFDR) 
> Spurious free dynamic range or SFDR is the ratio of the RMS signal amplitude to the RMS value of the peak spurious content, measured over the entire first Nyquist zone (DC to half of sampling frequency).

无杂散动态范围(SFDR) 指的是信号的均方根值与最差杂散信号(无论它位于频谱中何处)的均方根值之比。最差杂散可能是原始信号的谐波，也可能不是。在通信系统中，SFDR是一项重要指标，因为它代表了可以与大干扰信号(阻塞信号)相区别的最小信号值。SFDR可以相对于满量程(dBFS)或实际信号幅度(dBc)来规定。图4以图形化方式说明了SFDR的定义。
### 信纳比(SINAD)
> Signal to noise and distortion ratio, or SINAD is the ratio of the RMS signal amplitude to the mean value of the root-sum-squares of all other spectral components and harmonics, excluding DC.


少数ADC数据手册有时会将SINAD与SNR混为一谈，因此在解读这些规格时必须小心，务必弄清制造商的确切含义。
### 有效位数(ENOB)
> Effective number of bits or ENOB represents the actual resolution of an ADC after considering internal noise and errors. It is given by ENOB=(SINAD−1.76)/6.02


### 换算关系

$$
SNR = 20log_{10}\frac{S}{N}
$$

$$
THD = 20log_{10}\frac{S}{D}
$$

$$
SINAD = 20log_{10}\frac{S}{N+D}
$$

## ADC DC Measurement
### Offset Error
> Offset error represents the offset of the ADC transfer function curve from it ideal value at a single point.

### Gain Error
> Gain error represents the deviation of the slope of the ADC transfer function curve from its ideal value.

### INL Error
> Integral nonlinearity (INL) error, also termed as relative accuracy, is the maximum deviation of the measured transfer function from a straight line. The straight line is can be a best fit using standard curve fitting technique, or drawn between the end points of the actual transfer function after gain adjustment.

> The best fit method gives a better prediction of distortion in AC applications, and a lower value of linearity error. The endpoint method is mostly used in measurement application of data converters, since the error budget depends on the actual deviation from ideal transfer function.

INL(Integral Non-linearity)积分非线性，标示的是ADC的精度。它是指ADC器件在所有的数值点上对应的模拟值和真实值之间误差最大的那一点的误差值，表示测量值的绝对误差。一般有如下两种指示方法：

### DNL Error
> Differential nonlinearity (DNL) is the deviation from the ideal difference (1 LSB) between analog input levels that trigger any two successive digital output levels. The DNL error is the maximum value of DNL found at any transition.

DNL(Differential Non-linearity)微分非线性，它是指ADC相邻两刻度之间的差值的最大值，也叫差分非线性。反映的是整个量程范围内的局部微观非线性情形。

INL是DNL误差的数学积分，即一个具有良好INL的ADC保证有良好的DNL。

## References

[ADC AC Measurement](https://www.mathworks.com/help/msblks/ref/adcacmeasurement.html)

[ADC DC Measurement](https://www.mathworks.com/help/msblks/ref/adcdcmeasurement.html)

