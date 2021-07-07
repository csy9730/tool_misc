# LIS2DH12应用总结



LIS2DS12 TR LGA-12 ST意法 计步功能 加速传感器 全新原装正品
价格
¥6.50

https://www.st.com/resource/en/datasheet/lis3dh.pdf



金城孤客 2019-02-21 20:38:16  11538  收藏 15
分类专栏： 应用总结 文章标签： LIS2DH12 三轴加速度 传感器
版权
LIS2DH12的功能和特色如下：
• I2C/SPI两种通信接口
• 1Hz~5.3kHz的ODR可配置
• high-resolution/normal/low-power三种运行模式
high-resolution模式时输出为12bits
normal模式时输出为10bits
low-power模式时输出为8bits；
• 测量范围 ±2g/±4g/±8g/±16g可选
• 两个可配置的中断资源INT1和INT2
• 内置温度传感器
• 内置FIFO
• 两个中断输出引脚
• 6D/4D方向检测 6D/4D orientation detection
• 自由落体检测 Free-fall detection
• 动作检测 Motion detection
• 单击/双击识别 Click/double-click recognition
• 自动休眠/唤醒 Sleep-to-wake and return-to-sleep
其中6D/4D方向检测、自由落体检测和动作检测并不是由独立的单元实现的，这三种功能的实现都是通过对可配置中断资源INT1和INT2进行设置后实现的。
单击/双击识别和自动休眠/唤醒都是由独立的单元实现的，其中单击/双击识别有相应的中断标志位，自动休眠/唤醒没有标志位。

加速度原始数据读取计算
rang范围可设定为±2g、±4g、±8g、±16g （1g=9.8N/kg，正常不动，三轴的向量和为1g）
ADC可设置成8bit、10bit、12bit。
数据读取
sensor用了16bit来表示一个轴的值。即读取出来的原始寄存器数据为一个int16_t格式的数值。
lis2dhReadReg(LIS2DH_OUT_Y_L, buf, 4);
tempAccY=(int16_t)((buf[1]<<8)+buf[0])>>6;
tempAccZ=(int16_t)((buf[3]<<8)+buf[2])>>6;
temp_f_y=(int32_t)(tempAccYx38.28);
temp_f_z=(int32_t)(tempAccZx38.28); //±2G，256LBS/g 放大1000倍 9800/256 = 38.28 mg

举例以配置为±8g，10bit为例：
10bit的数值范围为-512到+512，不管rang设置多大，输出的范围是固定的。
range设置成±8g是，测量范围为-8g ~ +8g，数字化后，即为64LSB/g，即1g的加速度对应的输出是64。同理：1个数字代表的加速度为8/512=15.6mg

数据连续读取
连续读取多个数据，和普通的I2C读取有一定区别，需要地址最高位置1，注意Datasheet有如下一句话：
“In order to read multiple bytes, it is necessary to assert the most significant bit of the subaddress field. In other words, SUB(7) must be equal to 1 while SUB(6-0) represents the
Address of the first register to be read.”


运动中断唤醒设置

CTRL_REG1 = 0x1F；//1MHz,低功耗模式，X/Y/Z都使能
CTRL_REG2 = 0x01;//INT1上使用High-pass
CTRL_REG3 = 0x40;//INT1上产生中断。
INT1_CFG = 0x2A;//使能，X/Y/Z任一超过阈值中断。
INT1_THS = 0x10；//中断阈值 16*FS
INT1_DURATION = 0x00;//超过时立刻产生中断。