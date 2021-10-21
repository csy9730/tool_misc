# [Microcontroller vs PLC: A Detailed Comparison](https://circuitdigest.com/article/microcontroller-vs-plc-detailed-comparison-and-difference-between-plc-and-microcontroller)

[EMBEDDED](https://circuitdigest.com/embedded)

By**Emmanuel Odunlade** Oct 03, 2018[0](https://circuitdigest.com/article/microcontroller-vs-plc-detailed-comparison-and-difference-between-plc-and-microcontroller#comments)

![Comparison and Difference between Microcontroller and PLC](https://circuitdigest.com/sites/default/files/field/image/PLC-vs-Microcontroller.jpg)Comparison and Difference between Microcontroller and PLC



The advent of Arduino and scores of other microcontroller based boards in recent times has increased the interest in [embedded systems](https://circuitdigest.com/embedded), opening up the world of microcontrollers to a great number. This has not only increased the number of microcontroller users, but also increased the scope and applications in which they are used. That’s why over the past few articles, we have covered some key topics that are important for building great embedded systems devices like; [selecting the right microcontroller for your project](https://circuitdigest.com/article/how-to-select-the-right-microcontroller-for-your-embedded-application), [Selecting between a Microcontroller and Microprocessor](https://circuitdigest.com/article/selecting-between-a-microcontroller-and-microprocessor). In the same vein, for today’s article, I will be **comparing microcontrollers to Programmable logic controller (PLCs)**.

### **Programmable Logic Controller**

A **Programmable logic controller** (PLC) is simply a special purpose computing device designed for use in industrial control systems and other systems where the reliability of the system is high.

<iframe frameborder="0" src="https://0e09afd22fd8c90ea16701b15286cf7d.safeframe.googlesyndication.com/safeframe/1-0-38/html/container.html" id="google_ads_iframe_/21034905/Leaderboard_2_0" title="3rd party ad content" name="" scrolling="no" marginwidth="0" marginheight="0" width="728" height="90" data-is-safeframe="true" sandbox="allow-forms allow-popups allow-popups-to-escape-sandbox allow-same-origin allow-scripts allow-top-navigation-by-user-activation" data-google-container-id="a" data-load-complete="true" style="box-sizing: border-box; max-width: 100%; border: 0px; vertical-align: bottom;"></iframe>

![Programmable Logic Controller](https://circuitdigest.com/sites/default/files/inlineimages/u/Programmable-Logic-Controller.jpg)

They were initially developed to replace hardwired relays, sequences and timers used in the manufacturing process by the automation industry, but today they have scaled and are being used by all kind of manufacturing processes including robot based lines. These days, there is probably no single factory in the word that does not have a machine or equipment running on PLCs. The main reason for their wide adoption and use can be found deeply rooted in their ruggedness and **ability to withstand the rough handling/environment** associated with manufacturing floors. They are also a good example of **real time operating systems** as they have high ability to produce outputs to specific inputs within a very short timeframe which is a key requirement for industrial settings as a second delay could disrupt the entire operation.

### **Microcontrollers**

![Microcontroller](https://circuitdigest.com/sites/default/files/inlineimages/u/Microcontroller.jpg)

**Microcontrollers** on the other hand are small computing devices on a single chip that contain one or more processing cores, with memory devices embedded alongside programmable special and general purpose input and output (I/O) ports. They are used in all sort of day to day devices especially in applications where only specific repetitive tasks need to be performed. They are usually bare and cannot be used as standalone devices without the necessary connections. Unlike PLCs, **they do not have interfaces like display, and switches built in** as they usually just have GPIOs to which these components can be connected.

Today’s tutorial will be focussed on **comparing PLCs and Microcontroller systems under different headings** which include;

1. Architecture
2. Interfaces
3. Performance and Reliability
4. Required Skill Level
5. Programming
6. Applications

### **1. Architecture**

**PLCs Architecture:**

PLCs generally can be referred to as a high level microcontroller. **They are essentially made up of a processor module, the power supply, and the I/O modules**. The processor module consists of the central processing unit (CPU) and memory. In addition to a microprocessor, the CPU also contains at least an interface through which it can be programmed (USB, Ethernet or RS232) along with communication networks. The power supply is usually a separate module, and the I/O modules are separate from the processor. The types of I/O modules include discrete (on/off), Analog (continuous variable), and special modules like motion control or high-speed counters. The field devices are connected to the I/O modules.

![PLCs Architecture](https://circuitdigest.com/sites/default/files/inlineimages/u/PLCs-Architecture.png)

Depending on the amount of I/Os modules possessed by the PLC, they may be in the same enclosure as the PLC or in a separate enclosure. Certain small PLCs called nano/micro PLCs usually have all their parts including power, processor etc. in the same enclosure.

![Nano/micro PLCs](https://circuitdigest.com/sites/default/files/inlineimages/u/nano-micro-PLCs.jpg)

**Microcontroller’s Architecture**

The architecture of PLCs described above is somewhat similar to the microcontrollers in terms of constituents, but the microcontroller implements everything on a single chip, from the CPU to the I/O ports and interfaces required for communication with the outside world. Architecture of the microcontroller is shown below.

![img](https://circuitdigest.com/sites/default/files/inlineimages/Microcontroller-Block-Diagr.gif)

Just like the microcontroller has diverse architecture from the AVR architecture to the 8051 architecture, PLCs likewise have variations in their design which supports the configuration and desire of a particular manufacturer but they generally all adhere to the industry standard (IEC 61131-3) for PLCs. This standard fosters interoperability between modules and parts.

### **2. Interfaces**

PLCs are standard designed to interface with industrial grade sensors, actuators, and communication modules and are thus given current and voltage ratings which are often incompatible with microcontrollers without extra hardware.

PLCs usually use Ethernet, and several variations of the RS- serial series like RS-232, RS-485 for communication. The advent of the industrial [internet of things](https://circuitdigest.com/internet-of-things) nowadays, is creating a surge in the number of connected PLC devices capable of transmitting data over wireless communication interfaces.

As mentioned earlier, they come in different sizes, from small devices (with few IO pins/modules) which are referred to as building blocks to large, giant rack mounted PLCs with hundreds of IOs.

**Microcontrollers** as well have sensors, actuators, and modules designed to meet their specific needs which might be difficult to interface with a PLC.  They are however usually designed to handle processing of only a few 100 IOs. While several techniques can be explored to increase the IOs of the microcontroller, this are still possible with PLCs and is thus not unique to the microcontrollers, asides from the fact that it increases the entire project budget.

### **3. Performance, Sturdiness and Reliability**

**This is by far the point under which the PLC distinguishes itself the most**. As mentioned initially, the PLC was designed for use in industrial setups and was thus fortified to be able to withstand several adverse conditions associated with that environment like, extreme temperature ranges, electrical noise, rough handling and high amount of vibration. PLCs are also a good example of real time operation system due to their ability to produce outputs within the shortest time possible after evaluating an input. This is very important in industrial system as timing is a huge part of the manufacturing plant/process.

**Microcontrollers** however are less sturdy. By design they were not designed to serve as standalone devices like PLCs. They were designed to be embedded in a system. This provides an explanation for their less sturdy look compared to PLCs. For these reasons, microcontrollers may fail when deployed in certain scenarios as the chips are fragile and can easily be damaged.

### **4. Skill Requirement for Use**

**One of the key attributes of the PLC is the low technical knowledge required** for programming, and generally operating it. The PLC was designed to be use by both the highly skilled automation experts and factory technicians who have little or no formal training. It is relatively easy to troubleshoot and diagnose faults. Modern PLC devices usually come with a display screen that makes things easier to monitor without sophisticated tools.

**Microcontrollers on the other hand however, require skilful handling**. Designers need to have a good knowledge of electrical engineering principles and programming to be able to design complementary circuits for the microcontroller. Microcontrollers also require special tools (e.g Oscilloscope) for fault diagnosis and firmware trouble shooting. Although several simplified platforms like the Arduino currently exists, it is still a lot more complex than the plug and play PLCs both from connection stand point, programming standpoint, and ease of use.

### **5. Programming**

For the sake of simplicity and ease of use by all knowledge classes, **PLCs were originally designed to be programmed using a visual of programming** that mimics the connections/schematics of relay logic diagrams. This reduced the training requirements for existing technicians. The primary, most popular programming language used for PLCs are the Ladder Logic and instruction list programming language. Ladder logic uses symbols, instead of words, to emulate the real world relay logic control, which is a relic from the PLC's history.  These symbols are interconnected by lines to indicate the flow of current through relay, like contacts and coils. The number of symbols has increased tremendously over the years enabling engineers to easily implement high level of functionalities.

![Ladder PLC Programming](https://circuitdigest.com/sites/default/files/inlineimages/u/Ladder-PLC-Programming.png)

An **example of a ladder logic/diagram** based code is shown above. It usually looks like a ladder which is the reason behind its name. This simplified look makes PLCs very easy to program such that if you can analyse a schematic, you can program PLCs.

Due to the recent popularity of modern high level programming languages, PLCs are now being programmed using these languages like C, C++ and basic but all PLCs generally still adhere to the industry IEC 61131/3 control systems standard and support the programming languages stipulated by the standard which include; Ladder Diagram, Structured Text, Function Block Diagram, Instruction List and Sequential Flow Chart.

Modern day PLC are usually programmed via application software based on any of the languages mentioned above, running on a PC connected to the PLC using any of, USB, Ethernet, RS232, RS-485, RS-422, interfaces.

**Microcontrollers on the other hand are programmed using low level languages like assembly or high level languages like C and C++ among others**. It usually requires a high level of experience with the programming language being used and a general understanding of the principles of firmware development. Programmers usually need to understand concepts like data structures and a deep understanding of the microcontroller architecture is required to develop a very good firmware for the project.

Microcontrollers are usually also programmed via application software running on a PC and they are usually connected to that PC via an additional piece of hardware usually called a **programmers**.

The operation of programs on the PLC is however very similar to that of the microcontroller. The PLC uses a dedicated controller as a result they only process one program over and over again. One cycle through the program is called a **scan** and it’s similar to a microcontroller going through a loop.

An **operating cycle through the program running on PLC** is shown below.

![PLC Program Architecture](https://circuitdigest.com/sites/default/files/inlineimages/u/PLC-Program-Architecture.png)

### **6. Applications**

**PLCs** are the primary control elements used in industrial control systems. They find application in the control of industrial machines, conveyors, robots and other production line machineries. They are also used in SCADA based systems and in systems that require a high level of reliability and ability to withstand extreme conditions. They are used in industries including;

\1. Continuous bottle filling system
2.Batch mixing system
3.stage air conditioning system
4.Traffic control

**Microcontrollers** on the other hand find application in everyday electronic devices. They are the major building blocks of several consumer electronics and smart devices.

### **Replacing PLCs in Industrial Applications with Microcontrollers**

The advent of easy to use microcontroller boards have increased the scope within which microcontrollers are being used, they are now being adapted for certain applications for which microcontrollers were considered inappropriate from mini DIY computers to several complex control systems. This has led to questions around **why microcontrollers are not used in place of PLCs**, the main argument being the cost of PLCs compared to that of microcontrollers. It is important that a lot needs to be done to the regular microcontrollers before it can be used in industrial applications.

While the answer can be found from the points already mentioned within this article, it is sufficient to highlight two key points.
\1. Microcontrollers are not designed with the ruggedness and ability to withstand extreme conditions like PLCs. This makes them not ready for industrial applications.

\2. Industrial sensors and actuators are usually designed according to the IEC standard which is usually at a range of current/voltage and interfaces which may not be directly compatible with microcontrollers and will require some sort of supporting hardware which increases cost.

Other points exist but to stay within the scope of this article, we should stop here.

Rounding up, each of these control devices is designed for use in certain systems and they should be well considered before a decision is made on the best one for a particular application. It is important to note that certain manufacturers are building Microcontroller based PLCs, like [industrial shields](https://www.industrialshields.com/slides-product-range-arduino-industrial-plc?utm_expid=.VeBCfnEfQxuL-28RgXkpKQ.1&utm_referrer=https%3A%2F%2Fwww.industrialshields.com%2Fslides-product-range-arduino-industrial-plc) now make Arduino based PLCs shown below.

![Arduino based PLCs](https://circuitdigest.com/sites/default/files/inlineimages/u/Arduino-based-PLCs.jpg)

- Tags

- [MICROCONTROLLER](https://circuitdigest.com/tags/microcontroller)
- [EMBEDDED](https://circuitdigest.com/tags/embedded)
- [PLC](https://circuitdigest.com/tags/plc)
- 
- 
- 
- 
- 
- 
- 
- 




  