# ADC的非线性误差DNL、INL的MATLAB简单计算及其方差最大值的计算

[![凡士林](https://pic3.zhimg.com/v2-eaac7c059753c916ed56431040dc6f0b_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/chen-yi-fan-17-5)

[凡士林](https://www.zhihu.com/people/chen-yi-fan-17-5)





6 人赞同了该文章



目录

收起

定义

计算

inldnl()函数

根据定义的简陋版

方差最大值的计算

INL-MAX的计算

DNL-MAX的计算

## 定义

由于各种非理想因素的影响，理想的数据转换器的DNL和INL往往都不为零，数值越大，说明Linearity 越差。

**DNL：**微分非线性。指的是数字输出每增加“1”时，输出模拟量的变化值与LSB的差距。

DNL=Ai−Ai−1−LSBLSB (2≤i≤2N−1)

**INL：**积分非线性。指模拟输出与理想输出之间的差距。

INL=Areal−Aideal

DNL和INL之间的关系为，INL等于DNL的累加，DNL等于相邻INL的差。

## 计算

### inldnl()函数

**inldnl(A,B,[0 1],'ADC')：**

- A：数据转换器的输入模拟量；
- B：数据转换器的输出数据量，也就是输出为“1”的位的电容之和；

Dout=∑1NCi−1Di

- [0 1]：表示输入模拟量的范围；
- 'ADC'：表示类型是ADC还是DAC。

利用A，B和[0 1]的值，该函数可以推算出ADC的位数。其输出是一个结构体，可以找到所需要的参数。

![img](https://pic4.zhimg.com/80/v2-1f055249e856782c9a0777ba0cd1fd8f_720w.jpg)inldnl()输出的结构体

【例】6bit的ADC，输入如下，是一个ramp信号，代表理想状态。

```matlab
vin_ramp=[0:1:2^N-1]/2^N;
```

![img](https://pic3.zhimg.com/80/v2-eccfd226fbf8313ea37fac40becd9d7a_720w.jpg)输入输出信号

即选择了 2N 个点，每个点之间的间隔为LSB。

```matlab
A=vin_ramp;
B=out_digi_ramp;
struct_adc=inldnl(A,B,[0 1],'ADC');
figure(1)
subplot(2,1,1);
plot(struct_adc.INL);
grid on;
title('INL') 
xlabel('Digital Code')
ylabel('INL/LSB')
subplot(2,1,2);
plot(struct_adc.DNL);
grid on;
title('DNL') 
xlabel('Digital Code')
ylabel('DNL/LSB')
```

结果为

![img](https://pic4.zhimg.com/80/v2-b97197daffc3225936f2d75a28e3f60f_720w.jpg)inldnl()结果

### 根据定义的简陋版

输入使用与inldnl()时相同的ramp信号。

```matlab
A=vin_ramp';
B=out_digi_ramp;
DNL=zeros(2^N-1,1);
INL=zeros(2^N,1);
b=size(B)/(2^N);
LSB=1/2^N;
i=2;
B=B/(2^N);
for j=1:1:2^N-1
    DNL(j)=(B(i,1)-B(i-1,1)-LSB)/LSB;                  
    INL(j+1)=(B(i,1)-A(i,1))/LSB;                       
    i=i+1;
end
INL(1)=(B(1,1)-A(1,1))/LSB;
figure(1)
subplot(2,1,1);
plot(-INL);
grid on;
title('-INL') 
xlabel('Digital Code')
ylabel('INL/LSB')
subplot(2,1,2);
plot(-DNL);
grid on;
title('-DNL') 
xlabel('Digital Code')
ylabel('DNL/LSB')
```

![img](https://pic3.zhimg.com/80/v2-89157073c5d8797ddcf3249ea82c5992_720w.jpg)简陋版结果

其结果看起来与第一种方法类似。看起来反而是简陋版的更贴近定义，欢迎指正。

## 方差最大值的计算

当电路中的电容两端的电压变化最大时，INL、DNL变化最大，如数字输出从100变化到011。

### INL-MAX的计算

电容阵列中的电容可表示为： Ci=2i−1Cu+δi ，其中 δi 服从均值为0，方差为 2i−1σu2 的正态分布，则有 E(δi2)=2i−1σu2 。

则引入的误差电压可表示为： Ve=∑i=1Nδi2NCuSnVref （假设输出为1时，电容极板接Vref）。

该误差的方差为： EVe2=∑i=1N2i−1σu2Vref2Sn22NCu2=ΔCσu2Vref2Ctot2

由此得到一种简便计算方法是 σINL−max=ΔCCtot2ΔV2σu

其中：

ΔC ：指转换过程中电容极板中两端电压发生变化的单位电容总数,是数目不是电容的大小；

Ctot :电容阵列中的总电容大小；

ΔV ：每次转换，电容极板转换的电压；

σu :失配标准差。

【注】差分输入时，总电容大小翻两倍，转换过程中电容羁绊两端电压发生变化的电容总数也翻两倍，所以 σINL−max 要除以根号2。

### DNL-MAX的计算

根据前面的讨论，INL等于DNL的累加，那么DNL可以表示为相邻两次INL的差。

DNL=Vei−Vei−1

σDNL−max=EDNL2=EVei2+EVei−12

一般都是从0111……到1000……时，DNL和INL最大，此时 EVei2 和 EVei−12 在分子上只相差1，若将其忽略不计，则可以推出当从0111……到1000……时， σDNL−max 是 σINL−max 的根号2倍。

【注】

①如果是上极板采样，采样后即刻进行比较，那么在1000……处的INL一定为0，此时σDNL−max 是 σINL−max 的根号2倍的说法便不再成立，而是相等关系，因为此时有 EVei2=0 。

②同侧电容极板上电压同时变化时的INL也为0，例如在 VFs/2 、 VFs/4 以及 3VFs/4 处的INL为0，那么在计算 σDNL−max 时便是从001111……到010000……或者从101111……到110000……时DNL、INL最大，此时变化的电容只需要考虑次最高位电容及其后面的电容。

编辑于 2021-12-28 20:46

模拟ADC

模数转换器

非线性