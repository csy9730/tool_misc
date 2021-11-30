# grblHAL
[https://www.grbl.org/what-is-grblhal](https://www.grbl.org/what-is-grblhal)

[https://github.com/grblHAL/core](https://github.com/grblHAL/core)

[https://github.com/terjeio/grblHAL](https://github.com/terjeio/grblHAL)


 
> GRBL分成两部分：处理器相关代码-硬件抽象层和 处理器无关代码-GRBL内核
> 硬件抽象层HAL的代码包含处理器初始化，计时器，PWM硬件，端口，通信方式等。
> 移植grblHAL到新的微控制器是直接的，开发者从驱动模板开始，需要修改驱动文件，不需要理解GRBL内核。


## What is grblHAL?

In the last 5 years a number of software developers independently recognized that 8-bit GRBL had reached it's limits on the Arduino. They set their sights on porting it to one of a number of the emerging, inexpensive 32-bit machines, especially ARM based microcontrollers. While these ports worked, they threatened to cause fragmentation of the GRBL world. Because GRBL was so finely honed to take efficient advantage of the Arduino's Atmel microcontroller, machine specific code was intermingled with machine independent code and made it difficult to port. Also, any new features added or bugs fixed in one version would have to be retrofitted to other ports. Very quickly there were new features in one port that weren't available in others. There was no master source that all the different 32-bit versions could be built from. Moving to a new microcontroller or even a different variant in the same family required an in-depth understanding of the workings of GRBL.


Terje Io, a talented and forward looking Norwegian software developer, saw this and started work on a solution to the problem. He split GRBL into two parts: one that contains all the processor dependent code - a Hardware Abstraction Layer (HAL) and one that does not - the GRBL core. Thus, grblHAL was born. The HAL contains code that initializes the processor, knows about timers, PWM hardware, ports, pin addresses, communications and such. The GRBL core only interacts with the HAL. Moving grblHAL to a new microcontroller takes a few weeks or even days in some cases because the HAL layer is relatively small. In addition, bug fixes or new features to the GRBL core can be added for the benefit of all versions. 

Porting grblHAL to a new microcontroller is straightforward. Basically a single driver file defines the hardware abstraction for the target processor. A developer can start with an existing driver or a template ARM driver. Because most of the code they need to modify is in the driver file, they do not need to understand the GRBL Core.

 

[![grblhal diagram.png](https://static.wixstatic.com/media/c35ea0_140b358666d54ef88473d8d69e257f83~mv2.png/v1/crop/x_0,y_7,w_1050,h_976/fill/w_283,h_263,al_c,q_85,usm_0.66_1.00_0.01/grblhal%20diagram.webp)](https://www.grbl.org/grblhal)

![grblhal.png](https://static.wixstatic.com/media/c35ea0_91b142f9e3c84e76abcdc7cb2c57d1bb~mv2.png/v1/fill/w_265,h_178,al_c,q_85,usm_0.66_1.00_0.01/grblhal.webp)

As of August 2020, gbrlHAL has been ported to 13 different microcontrollers:

- ST Microsystems STF32F1xx (Blue Pill)
- ST Microsystems STM32F4xx (Black Pill)
- Espressif Systems ESP32
- NXP Semiconductors iMRXT1062 (Teensy 4.x)
- NXP Semiconductors LPC1768/1769
- Texas Instruments MSP430F5529 (16-bit)
- Texas Instruments MSP432
- Texas Instruments MSP432E401Y
- Texas Instruments TMC123
- Texas Instruments TMC129x
- Cypress Semiconductor PSoC5
- Microchip SAM3X8E (Arduino Due)
- Microchip SAMD21 (Arduino MKRZERO)

## [The benefits of grblHAL](https://www.grbl.org/benefits-of-grblhal)

- [  ](http://www.facebook.com/wix)