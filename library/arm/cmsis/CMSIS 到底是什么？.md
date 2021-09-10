## CMSIS 到底是什么？

先来看看ARM公司对CMSIS的定义：

ARM® Cortex™ 微控制器软件接口标准 (CMSIS) 是 Cortex-M 处理器系列的与供应商无关的硬件抽象层。

CMSIS 可实现与处理器和外设之间的一致且简单的软件接口，从而简化软件的重用，缩短微控制器开发人员新手的学习过程，并缩短新设备的上市时间。

软件的创建是嵌入式产品行业的一个主要成本因素。通过跨所有 Cortex-M 芯片供应商产品将软件接口标准化（尤其是在创建新项目或将现有软件迁移到新设备时），可以大大降低成本。

我们知道，不同厂家，比如FSL，ST，Energy Micro等不同厂家的内核都是使用Cortex M，但是这些MCU的外设却大相径庭，外设的设计、接口、寄存器等都不一样，

因此，一个能够非常熟练使用STM32软件编程的工程师很难快速地上手开发一款他不熟悉的，尽管是Cortex M内核的芯片。

而CMSIS的目的是让不同厂家的Cortex M的MCU至少在内核层次上能够做到一定的一致性，提高软件移植的效率。

\1. CMSIS的结构：

CMSIS 包含以下组件：

- CMSIS-CORE：提供与 Cortex-M0、Cortex-M3、Cortex-M4、SC000 和 SC300 处理器与外围寄存器之间的接口
- CMSIS-DSP：包含以定点（分数 q7、q15、q31）和单精度浮点（32 位）实现的 60 多种函数的 DSP 库
- CMSIS-RTOS API：用于线程控制、资源和时间管理的实时操作系统的标准化编程接口
- CMSIS-SVD：包含完整微控制器系统（包括外设）的程序员视图的系统视图描述 XML 文件

此标准可进行全面扩展，以确保适用于所有 Cortex-M 处理器系列微控制器。其中包括所有设备：

从最小的 8 KB 设备，直至带有精密通信外设（例如以太网或 USB）的设备。

（内核外设功能的内存要求小于 1 KB 代码，低于 10 字节 RAM）。

![img](https://images0.cnblogs.com/blog/268182/201310/02212113-ac622b267ac842739eff6bbb44f28a1c.jpg)![img](https://images0.cnblogs.com/blog/268182/201310/02212130-27d5378da6a544259a0771ae5730caef.jpg)

看了这张图的含义更清楚些，CMSIS-RTOS在用户的应用代码和第三方的RTOS Kernel直接架起一道桥梁，一个设计在不同的RTOS之间移植，

或者在不同Cortex MCU直接移植的时候，如果两个RTOS都实现了CMSIS-RTOS，那么用户的应用程序代码完全可以不做修改。

 

## CMSIS SVD(System View Description) 系统视图说明

 

系统视图描述 (SVD) 文件以基于格式化的 XML 提供了外设信息和其他设备参数。

SVD 文件通常与设备参考手册中芯片供应商提供的信息相匹配。

SVD相当于把传统的芯片手册（DATA SHEET)给“数字化”了， 手册是给人看的，而SVD采用XML文档结构化的方式，是给机器、开发环境、MDK/IAR等软件“看”的，

SVD文件中定义了某个芯片的非常详细的信息，包含了哪些片内外设，每一个外设的硬件寄存器，每一个寄存器中每一个数据位的值，以及详细的说明信息等等。 

SVD足够详细，与手册内容完全匹配，根据SVD文件可以生成芯片的头文件定义，厉害吧！

因此，SVD文件的内容非常详细，基本上人看不懂，虽然是XML，但看起来还是像天书一样，但对于软件、工具，则是清晰明了。 

 

<http://www.keil.com/pack/doc/cmsis/svd/html/index.html>

 

## System View Description

 

This chapter contains the introduction and specification of the CMSIS System View Description format (CMSIS-SVD).

The introduction section outlines the objectives and benefits CMSIS-SVD.

**Introduction**

CMSIS-SVD formalizes the description of the programmer's view for the system contained in ARM Cortex-M processor-based microcontrollers,

in particular the memory mapped registers of the peripherals.

The detail contained in system view descriptions is comparable to what is found in device reference manuals published by silicon vendors.

The information ranges from a high level functional description of a peripheral all the way down to the definition and purpose of an individual bit field in a memory mapped register.

CMSIS-SVD files are developed and maintained by the silicon vendors. Silicon vendors manage their descriptions in a central,

web-based Device Database and the CMSIS-SVD files are downloadable via a public web interface once they have been released by the silicon vendor.

Tool vendors use these descriptions for providing device-specific debug views of peripherals in their debugger.

Last but not least CMSIS compliant device header files are generated from CMSIS-SVD files.

**CMSIS-SVD Benefits**

- The benefits for the Software Developer:
  - Consistency between device header file and what is being displayed by the debugger.
  - Detailed information about peripherals, registers, fields, and bit values from within the debugger, without the need to reference device documentation.
  - Public access via a web interface to new and updated descriptions as they become available from silicon vendors.
  - Improved software development efficiency.

- The benefits for the Silicon Vendor:
  - A tool vendor independent file format enables early device support by a wide range of toolchains with limited effort.
  - The XML-based format helps ease the integration into in-house design flows.
  - Automated generation of CMSIS compliant device header files.
  - Full control throughout the life cycle of the CMSIS-SVD files from creation to maintenance via the web-based Device Database.

- The benefits for the Tool Vendor:
  - Unified file format across silicon vendors helps the efficiency of supporting a wide range of new devices in a timely manner.
  - Silicon vendors provide early review access to individuals ahead of the publishing date.
  - Updated descriptions are available over the web simplifying the maintenance of device support.

 

##  SVD File Description 

The CMSIS-SVD format is based on XML. The specification of the System View Description format was influenced by IP-XACT,

a design description format used in, for example, IP stitching and IP reuse. Due to the much wider scope and complexity of IP-XACT it was decided to specify a separate format,

which is focused and tailored toward the description of the programmer's view of a device only.

**CMSIS-SVD XML Hierarchy**

**![img](https://images0.cnblogs.com/blog/268182/201310/02213941-da9fe5d8747c467299f616101bd7e358.png)**

One CMSIS-SVD file contains the description of a single device. A device consists of a processor and at least one peripheral. Each peripheral contains at least one register. A register may consist of one or more fields. The range of values for a field may be further described with enumerated values.

- **Device Level:** The top level of a System View Description is the device. On this level, information is captured that is specific to the device as a whole. For example, the device name, description, or version. The minimal addressable unit as well as the bit-width of the data bus are required by the debugger to perform the correct target accesses.

  Default values for register attributes like register size, reset value, and access permissions can be set for the whole device on this level and are implicitly inherited by the lower levels of the description. If however specified on a lower level, the default setting from a higher level will get overruled.

- **Peripherals Level:** A peripheral is a named collection of registers. A peripheral is mapped to a defined *base address* within the device's address space. A peripheral allocates one or more exclusive address blocks relative to its base address, such that all described registers fit into the allocated address blocks. Allocated addresses without an associated register description are automatically considered reserved. The peripheral can be assigned to a group of peripherals and may be associated with one or more interrupts.

- **Registers Level:** A register is a named, programmable resource that belongs to a peripheral. Registers are mapped to a defined address in the address space of the device. An address is specified relative to the peripheral base address. The description of a register documents the purpose and function of the resource. A debugger requires information about the permitted access to a resource as well as side effects triggered by read and write accesses respectively.

- **Fields Level:** Registers may be partitioned into chunks of bits of distinct functionality. A chunk is referred to as *field*. The field names within a single register must be unique. Only architecturally defined fields shall be described. Any bits not being explicitly described are treated as reserved. They are not displayed in the System Viewer and are padded in the bit fields of the device header file. The case-insensitive field named **"reserved"** is treated as a keyword and each field with this name is ignored.

- **Enumerated Values Level:** An enumeration maps an unsigned integer constant to a descriptive identifier and, optionally, to a description string. Enumerations are used in C to enhance the readability of source code. Similarly, it can be used by debuggers to provide more instructive information to the programmer, avoiding a lookup in the device documentation.

- **Vendor Extensions:** The CMSIS-SVD format includes a section named *vendorExtensions* positioned after the closing tag *peripherals*. This allows silicon vendors and tool partners to innovate and expand the description beyond the current specification.

**Multiple Instantiation**

CMSIS-SVD supports the reuse of whole sections of the description. The attribute *derivedFrom* for the peripheral-, register-, and field-section specifies the source of the section to be copied from. Individual tags can be used to redefine specific elements within a copied section. In case the name of the description source is not unique, the name needs to be qualified hierarchically until the element composite name becomes unique. Hierarchies are separated by a dot. For example, *<peripheral name>.<register name>.<field name>*.

**Peripheral Grouping**

Peripherals that provide similar functionality (Simple Timer, Complex Timer) can be grouped with the element *groupName*. All peripherals associated with the same group name are collectively listed under this group in the order they have been specified in the file. Collecting similar or related peripherals into peripheral groups helps structuring the list of peripherals in the debugger.

**Descriptions**

On each level, the tag *description* provides verbose information about the respective element. The description field plays an important part in improving the software development productivity as it gives instant access to information that otherwise would need to be looked up in the device documentation.

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
<?xml version="1.0" encoding="utf-8"?>

<!-- File naming: <vendor>_<part/series name>.svd -->

<!--
  Copyright (C) 2012 ARM Limited. All rights reserved.

  Purpose: System Viewer Description (SVD) Example (Schema Version 1.0)
           This is a description of a none-existent and incomplete device
           for demonstration purposes only.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
   - Redistributions of source code must retain the above copyright
     notice, this list of conditions and the following disclaimer.
   - Redistributions in binary form must reproduce the above copyright
     notice, this list of conditions and the following disclaimer in the
     documentation and/or other materials provided with the distribution.
   - Neither the name of ARM nor the names of its contributors may be used 
     to endorse or promote products derived from this software without 
     specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
  ARE DISCLAIMED. IN NO EVENT SHALL COPYRIGHT HOLDERS AND CONTRIBUTORS BE
  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  POSSIBILITY OF SUCH DAMAGE.
 -->
 
<device schemaVersion="1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema-instance" xs:noNamespaceSchemaLocation="CMSIS-SVD_Schema_1_0.xsd" >
  <name>ARMCM3xxx</name>                                          <!-- name of part or part series -->
  <version>1.0</version>                                          <!-- version of this description -->
  <description>ARM 32-bit Cortex-M3 Microcontroller based device, CPU clock up to 80MHz, etc. </description>
  <addressUnitBits>8</addressUnitBits>                            <!-- byte addressable memory -->
  <width>32</width>                                               <!-- bus width is 32 bits -->
  <!-- default settings implicitly inherited by subsequent sections -->
  <size>32</size>                                                 <!-- this is the default size (number of bits) of all peripherals
                                                                       and register that do not define "size" themselves -->
  <access>read-write</access>                                     <!-- default access permission for all subsequent registers -->
  <resetValue>0x00000000</resetValue>                             <!-- by default all bits of the registers are initialized to 0 on reset -->
  <resetMask>0xFFFFFFFF</resetMask>                               <!-- by default all 32Bits of the registers are used -->

  <peripherals>
    <!-- Timer 0 -->
    <peripheral>
      <name>TIMER0</name>
      <version>1.0</version>
      <description>32 Timer / Counter, counting up or down from different sources</description>
      <groupName>TIMER</groupName>
      <baseAddress>0x40010000</baseAddress>
      <size>32</size>
      <access>read-write</access>

      <addressBlock>
        <offset>0</offset>
        <size>0x100</size>
        <usage>registers</usage>
      </addressBlock>

      <interrupt>
        <name>TIMER0</name>
        <value>0</value>
      </interrupt>

      <registers>
      <!-- CR: Control Register -->
        <register>
          <name>CR</name>
          <description>Control Register</description>
          <addressOffset>0x00</addressOffset>
          <size>32</size>
          <access>read-write</access>
          <resetValue>0x00000000</resetValue>
          <resetMask>0x1337F7F</resetMask>

          <fields>
            <!-- EN: Enable -->
            <field>
              <name>EN</name>
              <description>Enable</description>
              <bitRange>[0:0]</bitRange>
              <access>read-write</access>
              <enumeratedValues>
                <enumeratedValue>
                  <name>Disable</name>
                  <description>Timer is disabled and does not operate</description>
                  <value>0</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>Enable</name>
                  <description>Timer is enabled and can operate</description>
                  <value>1</value>
                </enumeratedValue>
              </enumeratedValues>
            </field>

            <!-- RST: Reset -->
            <field>
              <name>RST</name>
              <description>Reset Timer</description>
              <bitRange>[1:1]</bitRange>
              <access>write-only</access>
              <enumeratedValues>
                <enumeratedValue>
                  <name>Reserved</name>
                  <description>Write as ZERO if necessary</description>
                  <value>0</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>Reset_Timer</name>
                  <description>Reset the Timer</description>
                  <value>1</value>
                </enumeratedValue>
              </enumeratedValues>
            </field>

            <!-- CNT: Counting Direction -->
            <field>
              <name>CNT</name>
              <description>Counting direction</description>
              <bitRange>[3:2]</bitRange>
              <access>read-write</access>
              <enumeratedValues>
                <enumeratedValue>
                  <name>Count_UP</name>
                  <description>Timer Counts UO and wraps, if no STOP condition is set</description>
                  <value>0</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>Count_DOWN</name>
                  <description>Timer Counts DOWN and wraps, if no STOP condition is set</description>
                  <value>1</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>Toggle</name>
                  <description>Timer Counts up to MAX, then DOWN to ZERO, if no STOP condition is set</description>
                  <value>2</value>
                </enumeratedValue>
              </enumeratedValues>
            </field>

            <!-- MODE: Operation Mode -->
            <field>
              <name>MODE</name>
              <description>Operation Mode</description>
              <bitRange>[6:4]</bitRange>
              <access>read-write</access>
              <enumeratedValues>
                <enumeratedValue>
                  <name>Continous</name>
                  <description>Timer runs continously</description>
                  <value>0</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>Single_ZERO_MAX</name>
                  <description>Timer counts to 0x00 or 0xFFFFFFFF (depending on CNT) and stops</description>
                  <value>1</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>Single_MATCH</name>
                  <description>Timer counts to the Value of MATCH Register and stops</description>
                  <value>2</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>Reload_ZERO_MAX</name>
                  <description>Timer counts to 0x00 or 0xFFFFFFFF (depending on CNT), loads the RELOAD Value and continues</description>
                  <value>3</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>Reload_MATCH</name>
                  <description>Timer counts to the Value of MATCH Register, loads the RELOAD Value and continues</description>
                  <value>4</value>
                </enumeratedValue>
              </enumeratedValues>
            </field>

            <!-- PSC: Use Prescaler -->
            <field>
              <name>PSC</name>
              <description>Use Prescaler</description>
              <bitRange>[7:7]</bitRange>
              <access>read-write</access>
              <enumeratedValues>
                <enumeratedValue>
                  <name>Disabled</name>
                  <description>Prescaler is not used</description>
                  <value>0</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>Enabled</name>
                  <description>Prescaler is used as divider</description>
                  <value>1</value>
                </enumeratedValue>
              </enumeratedValues>
            </field>

            <!-- CNTSRC: Timer / Counter Soruce Divider -->
            <field>
              <name>CNTSRC</name>
              <description>Timer / Counter Source Divider</description>
              <bitRange>[11:8]</bitRange>
              <access>read-write</access>
              <enumeratedValues>
                <enumeratedValue>
                  <name>CAP_SRC</name>
                  <description>Capture Source is used directly</description>
                  <value>0</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>CAP_SRC_div2</name>
                  <description>Capture Source is divided by 2</description>
                  <value>1</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>CAP_SRC_div4</name>
                  <description>Capture Source is divided by 4</description>
                  <value>2</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>CAP_SRC_div8</name>
                  <description>Capture Source is divided by 8</description>
                  <value>3</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>CAP_SRC_div16</name>
                  <description>Capture Source is divided by 16</description>
                  <value>4</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>CAP_SRC_div32</name>
                  <description>Capture Source is divided by 32</description>
                  <value>5</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>CAP_SRC_div64</name>
                  <description>Capture Source is divided by 64</description>
                  <value>6</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>CAP_SRC_div128</name>
                  <description>Capture Source is divided by 128</description>
                  <value>7</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>CAP_SRC_div256</name>
                  <description>Capture Source is divided by 256</description>
                  <value>8</value>
                </enumeratedValue>
              </enumeratedValues>
            </field>

            <!-- CAPSRC: Timer / COunter Capture Source -->
            <field>
              <name>CAPSRC</name>
              <description>Timer / Counter Capture Source</description>
              <bitRange>[15:12]</bitRange>
              <access>read-write</access>
              <enumeratedValues>
                <enumeratedValue>
                  <name>CClk</name>
                  <description>Core Clock</description>
                  <value>0</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>GPIOA_0</name>
                  <description>GPIO A, PIN 0</description>
                  <value>1</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>GPIOA_1</name>
                  <description>GPIO A, PIN 1</description>
                  <value>2</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>GPIOA_2</name>
                  <description>GPIO A, PIN 2</description>
                  <value>3</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>GPIOA_3</name>
                  <description>GPIO A, PIN 3</description>
                  <value>4</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>GPIOA_4</name>
                  <description>GPIO A, PIN 4</description>
                  <value>5</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>GPIOA_5</name>
                  <description>GPIO A, PIN 5</description>
                  <value>6</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>GPIOA_6</name>
                  <description>GPIO A, PIN 6</description>
                  <value>7</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>GPIOA_7</name>
                  <description>GPIO A, PIN 7</description>
                  <value>8</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>GPIOB_0</name>
                  <description>GPIO B, PIN 0</description>
                  <value>9</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>GPIOB_1</name>
                  <description>GPIO B, PIN 1</description>
                  <value>10</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>GPIOB_2</name>
                  <description>GPIO B, PIN 2</description>
                  <value>11</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>GPIOB_3</name>
                  <description>GPIO B, PIN 3</description>
                  <value>12</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>GPIOC_0</name>
                  <description>GPIO C, PIN 0</description>
                  <value>13</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>GPIOC_5</name>
                  <description>GPIO C, PIN 1</description>
                  <value>14</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>GPIOC_6</name>
                  <description>GPIO C, PIN 2</description>
                  <value>15</value>
                </enumeratedValue>
              </enumeratedValues>
            </field>

            <!-- CAPEDGE: Capture Edge -->
            <field>
              <name>CAPEDGE</name>
              <description>Capture Edge, select which Edge should result in a counter increment or decrement</description>
              <bitRange>[17:16]</bitRange>
              <access>read-write</access>
              <enumeratedValues>
                <enumeratedValue>
                  <name>RISING</name>
                  <description>Only rising edges result in a counter increment or decrement</description>
                  <value>0</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>FALLING</name>
                  <description>Only falling edges  result in a counter increment or decrement</description>
                  <value>1</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>BOTH</name>
                  <description>Rising and falling edges result in a counter increment or decrement</description>
                  <value>2</value>
                </enumeratedValue>
              </enumeratedValues>
            </field>

            <!-- TRGEXT: Triggers an other Peripheral -->
            <field>
              <name>TRGEXT</name>
              <description>Triggers an other Peripheral</description>
              <bitRange>[21:20]</bitRange>
              <access>read-write</access>
              <enumeratedValues>
                <enumeratedValue>
                  <name>NONE</name>
                  <description>No Trigger is emitted</description>
                  <value>0</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>DMA1</name>
                  <description>DMA Controller 1 is triggered, dependant on MODE</description>
                  <value>1</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>DMA2</name>
                  <description>DMA Controller 2 is triggered, dependant on MODE</description>
                  <value>2</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>UART</name>
                  <description>UART is triggered, dependant on MODE</description>
                  <value>3</value>
                </enumeratedValue>
              </enumeratedValues>
            </field>

            <!-- Reload: Selects Reload Register n -->
            <field>
              <name>RELOAD</name>
              <description>Select RELOAD Register n to reload Timer on condition</description>
              <bitRange>[25:24]</bitRange>
              <access>read-write</access>
              <enumeratedValues>
                <enumeratedValue>
                  <name>RELOAD0</name>
                  <description>Selects Reload Register number 0</description>
                  <value>0</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>RELOAD1</name>
                  <description>Selects Reload Register number 1</description>
                  <value>1</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>RELOAD2</name>
                  <description>Selects Reload Register number 2</description>
                  <value>2</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>RELOAD3</name>
                  <description>Selects Reload Register number 3</description>
                  <value>3</value>
                </enumeratedValue>
              </enumeratedValues>
            </field>

            <!-- IDR: Inc or dec Reload Register Selection -->
            <field>
              <name>IDR</name>
              <description>Selects, if Reload Register number is incremented, decremented or not modified</description>
              <bitRange>[27:26]</bitRange>
              <access>read-write</access>
              <enumeratedValues>
                <enumeratedValue>
                  <name>KEEP</name>
                  <description>Reload Register number does not change automatically</description>
                  <value>0</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>INCREMENT</name>
                  <description>Reload Register number is incremented on each match</description>
                  <value>1</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>DECREMENT</name>
                  <description>Reload Register number is decremented on each match</description>
                  <value>2</value>
                </enumeratedValue>
              </enumeratedValues>
            </field>

            <!-- START: Starts / Stops the Timer/Counter -->
            <field>
              <name>S</name>
              <description>Starts and Stops the Timer / Counter</description>
              <bitRange>[31:31]</bitRange>
              <access>read-write</access>
              <enumeratedValues>
                <enumeratedValue>
                  <name>STOP</name>
                  <description>Timer / Counter is stopped</description>
                  <value>0</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>START</name>
                  <description>Timer / Counter is started</description>
                  <value>1</value>
                </enumeratedValue>
              </enumeratedValues>
            </field>
          </fields>
        </register>

        <!-- SR: Status Register -->
        <register>
          <name>SR</name>
          <description>Status Register</description>
          <addressOffset>0x04</addressOffset>
          <size>16</size>
          <access>read-write</access>
          <resetValue>0x00000000</resetValue>
          <resetMask>0xD701</resetMask>

          <fields>
            <!-- RUN: Shows if Timer is running -->
            <field>
              <name>RUN</name>
              <description>Shows if Timer is running or not</description>
              <bitRange>[0:0]</bitRange>
              <access>read-only</access>
              <enumeratedValues>
                <enumeratedValue>
                  <name>Stopped</name>
                  <description>Timer is not running</description>
                  <value>0</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>Running</name>
                  <description>Timer is running</description>
                  <value>1</value>
                </enumeratedValue>
              </enumeratedValues>
            </field>

            <!-- MATCH: Shows if a Match was hit -->
            <field>
              <name>MATCH</name>
              <description>Shows if the MATCH was hit</description>
              <bitRange>[8:8]</bitRange>
              <access>read-write</access>
              <enumeratedValues>
                <enumeratedValue>
                  <name>No_Match</name>
                  <description>The MATCH condition was not hit</description>
                  <value>0</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>Match_Hit</name>
                  <description>The MATCH condition was hit</description>
                  <value>1</value>
                </enumeratedValue>
              </enumeratedValues>
            </field>

            <!-- UN: Shows if an underflow occured -->
            <field>
              <name>UN</name>
              <description>Shows if an underflow occured. This flag is sticky</description>
              <bitRange>[9:9]</bitRange>
              <access>read-write</access>
              <enumeratedValues>
                <enumeratedValue>
                  <name>No_Underflow</name>
                  <description>No underflow occured since last clear</description>
                  <value>0</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>Underflow</name>
                  <description>A minimum of one underflow occured since last clear</description>
                  <value>1</value>
                </enumeratedValue>
              </enumeratedValues>
            </field>

            <!-- OV: Shows if an overflow occured -->
            <field>
              <name>OV</name>
              <description>Shows if an overflow occured. This flag is sticky</description>
              <bitRange>[10:10]</bitRange>
              <access>read-write</access>
              <enumeratedValues>
                <enumeratedValue>
                  <name>No_Overflow</name>
                  <description>No overflow occured since last clear</description>
                  <value>0</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>Overflow_occured</name>
                  <description>A minimum of one overflow occured since last clear</description>
                  <value>1</value>
                </enumeratedValue>
              </enumeratedValues>
            </field>

            <!-- RST: Shows if Timer is in RESET state -->
            <field>
              <name>RST</name>
              <description>Shows if Timer is in RESET state</description>
              <bitRange>[12:12]</bitRange>
              <access>read-only</access>
              <enumeratedValues>
                <enumeratedValue>
                  <name>Ready</name>
                  <description>Timer is not in RESET state and can operate</description>
                  <value>0</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>In_Reset</name>
                  <description>Timer is in RESET state and can not operate</description>
                  <value>1</value>
                </enumeratedValue>
              </enumeratedValues>
            </field>

            <!-- RELOAD: Shows the currently active Reload Register -->
            <field>
              <name>RELOAD</name>
              <description>Shows the currently active RELOAD Register</description>
              <bitRange>[15:14]</bitRange>
              <access>read-only</access>
              <enumeratedValues>
                <enumeratedValue>
                  <name>RELOAD0</name>
                  <description>Reload Register number 0 is active</description>
                  <value>0</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>RELOAD1</name>
                  <description>Reload Register number 1 is active</description>
                  <value>1</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>RELOAD2</name>
                  <description>Reload Register number 2 is active</description>
                  <value>2</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>RELOAD3</name>
                  <description>Reload Register number 3 is active</description>
                  <value>3</value>
                </enumeratedValue>
              </enumeratedValues>
            </field>
          </fields>
        </register>

        <!-- INT: Interrupt Register -->
        <register>
          <name>INT</name>
          <description>Interrupt Register</description>
          <addressOffset>0x10</addressOffset>
          <size>16</size>
          <access>read-write</access>
          <resetValue>0x00000000</resetValue>
          <resetMask>0x0771</resetMask>

          <fields>
            <!-- EN: Interrupt Enable -->
            <field>
              <name>EN</name>
              <description>Interrupt Enable</description>
              <bitRange>[0:0]</bitRange>
              <access>read-write</access>
              <enumeratedValues>
                <enumeratedValue>
                  <name>Disabled</name>
                  <description>Timer does not generate Interrupts</description>
                  <value>0</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>Enable</name>
                  <description>Timer triggers the TIMERn Interrupt</description>
                  <value>1</value>
                </enumeratedValue>
              </enumeratedValues>
            </field>

            <!-- MODE: Interrupt Mode -->
            <field>
              <name>MODE</name>
              <description>Interrupt Mode, selects on which condition the Timer should generate an Interrupt</description>
              <bitRange>[6:4]</bitRange>
              <access>read-write</access>
              <enumeratedValues>
                <enumeratedValue>
                  <name>Match</name>
                  <description>Timer generates an Interrupt when the MATCH condition is hit</description>
                  <value>0</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>Underflow</name>
                  <description>Timer generates an Interrupt when it underflows</description>
                  <value>1</value>
                </enumeratedValue>
                <enumeratedValue>
                  <name>Overflow</name>
                  <description>Timer generates an Interrupt when it overflows</description>
                  <value>2</value>
                </enumeratedValue>
              </enumeratedValues>
            </field>
          </fields>
        </register>

        <!-- COUNT: Counter Register -->
        <register>
          <name>COUNT</name>
          <description>The Counter Register reflects the actual Value of the Timer/Counter</description>
          <addressOffset>0x20</addressOffset>
          <size>32</size>
          <access>read-write</access>
          <resetValue>0x00000000</resetValue>
          <resetMask>0xFFFFFFFF</resetMask>
        </register>

        <!-- MATCH: Match Register -->
        <register>
          <name>MATCH</name>
          <description>The Match Register stores the compare Value for the MATCH condition</description>
          <addressOffset>0x24</addressOffset>
          <size>32</size>
          <access>read-write</access>
          <resetValue>0x00000000</resetValue>
          <resetMask>0xFFFFFFFF</resetMask>
        </register>
        
        <!-- PRESCALE: Prescale Read Register -->
        <register>
          <name>PRESCALE_RD</name>
          <description>The Prescale Register stores the Value for the prescaler. The cont event gets divided by this value</description>
          <addressOffset>0x28</addressOffset>
          <size>32</size>
          <access>read-only</access>
          <resetValue>0x00000000</resetValue>
          <resetMask>0xFFFFFFFF</resetMask>
        </register>
        
        <!-- PRESCALE: Prescale Write Register -->
        <register>
          <name>PRESCALE_WR</name>
          <description>The Prescale Register stores the Value for the prescaler. The cont event gets divided by this value</description>
          <addressOffset>0x28</addressOffset>
          <size>32</size>
          <access>write-only</access>
          <resetValue>0x00000000</resetValue>
          <resetMask>0xFFFFFFFF</resetMask>
        </register>


        <!-- RELOAD: Array of Reload Register with 4 elements-->
        <register>
          <dim>4</dim>
          <dimIncrement>4</dimIncrement>
          <dimIndex>0,1,2,3</dimIndex>
          <name>RELOAD[%s]</name>
          <description>The Reload Register stores the Value the COUNT Register gets reloaded on a when a condition was met.</description>
          <addressOffset>0x50</addressOffset>
          <size>32</size>
          <access>read-write</access>
          <resetValue>0x00000000</resetValue>
          <resetMask>0xFFFFFFFF</resetMask>
        </register>
      </registers>
    </peripheral>

    <!-- Timer 1 -->
    <peripheral derivedFrom="TIMER0">
      <name>TIMER1</name>
      <baseAddress>0x40010100</baseAddress>
      <interrupt>
        <name>TIMER1</name>
        <value>4</value>
      </interrupt>
    </peripheral>

    <!-- Timer 2 -->
    <peripheral derivedFrom="TIMER0">
      <name>TIMER2</name>
      <baseAddress>0x40010200</baseAddress>
      <interrupt>
        <name>TIMER2</name>
        <value>6</value>
      </interrupt>
    </peripheral>
  </peripherals>
</device>
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

 

 





分类: [CORTEX](https://www.cnblogs.com/shangdawei/category/474759.html)