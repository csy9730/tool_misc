# **EasyMotion Studio**



[https://www.technosoftmotion.com/ESM-um-html/index.html](https://www.technosoftmotion.com/ESM-um-html/index.html)



**EasyMotion Studio** is an integrated development environment for the setup and motion programming of Technosoft intelligent drives and motors. The output of **EasyMotion Studio** consists of a set of setup data and a motion program, which can be downloaded to the EEPROM of your Technosoft intelligent drive / intelligent motor, or saved onto your PC for later use.

EasyMotion Studio includes a set of evaluation tools like the Data Logger, the Control Panel and the Command Interpreter which help you to quickly develop, test, measure and analyze your motion application.

EasyMotion Studio works with **projects***.* A project contains one or several **Applications**.

Each application describes a motion system for one axis. It has 2 components: the **Setup** data and the **Motion** program and an associated axis number: an integer value between 1 and 255. An application may be used either to describe:

| 1.   | One axis in a multiple-axis system |
| ---- | ---------------------------------- |
|      |                                    |

| 2.   | An alternate configuration (set of parameters) for the same axis. |
| ---- | ------------------------------------------------------------ |
|      |                                                              |

In the first case, each application has a different axis number corresponding to the axis ID of the drives/motors from the network. All data exchanges are done with the drive/motor having the same address as the selected application. In the second case, all the applications have the same axis number.  

The setup component contains all the information needed to configure and parameterize a Technosoft drive/motor. This information is preserved in the drive/motor EEPROM in the *setup table*. The setup table is copied at power-on into the RAM memory of the drive/motor and is used during runtime.  

The motion component contains the motion sequences to do. These are described via a TML (Technosoft Motion Language) program, which is executed by the drives/motors built-in motion controller.

