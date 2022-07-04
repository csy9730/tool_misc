# 机器人学与OROCOS-KDL（一）简介

[![李健斌](https://pic1.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/li-jian-bin-75-80)

[李健斌](https://www.zhihu.com/people/li-jian-bin-75-80)

机器人



10 人赞同了该文章

## ﻿一、概述

本系列文章主要研究机器人学的基础理论，以及研究开源机器人库OROCOS-KDL对机器人算法的实现。本文所有错误不足欢迎指正或讨论。

## 二、机器人学

机器人学是人们设计和应用机器人的技术和知识。机器人系统不仅由机器人组成，还需要其他装置和系统连同机器人一起来共同完成必须的任务。[^1] 机器人学内容主要有：运动学、动力学、轨迹规划、速度规划等。

## 三、开源机器人控制软件OROCOS

“Orocos”代表“Open Robot Control Software”，即开源机器人控制软件。 Orocos 为软件开发人员提供了开源的机器人软件框架，提供了很多功能，方 便开发人员快速的开发机器人软件模块。[^2] Orocos 由 Kinematics Dynamics Library，Bayesian Filtering Library 及 Orocos Toolchain 组成。 官方网站：[orocos.org](https://link.zhihu.com/?target=http%3A//www.orocos.org/)

![img](https://pic4.zhimg.com/80/v2-efa0fc58c1951c6063147b77c3cc1e97_1440w.jpg)

KDL（Kinematics and Dynamics）：机器人运动学与动力学组件，为运动学提供了实时的动力学约束计算，这个组件非常有用，有了这个组件，很多机器人开发者可以快速地开发机器人算法。 BFL（Bayesian Filtering Library）：贝叶斯过滤库提供了一个独立于应用程序的动态贝叶斯网络推导框架，即基于贝叶斯规则的递归信息处理和估计算法，如卡尔曼滤波器，粒子滤波器法等。 Toolchain：Orocos工具链是使用模块化运行时可配置软件组件创建实时机器人应用程序的主要工具。工具链包含了实时工具集（Real-Time Toolkit）、Orocos组件库（Orocos Component Library）等。 本文主要研究与机器人学相关的机器人运动学与动力学组件KDL。

## 四、OROCOS-KDL安装

## 1.参考平台

Windows 10 操作系统 MinGW 编译器 CMake 3.1.2 工具

## 2.源码下载

[Eigen3](https://link.zhihu.com/?target=http%3A//eigen.tuxfamily.org/)源码下载

> git clone [https://github.com/eigenteam/eigen-git-mirror.git](https://link.zhihu.com/?target=https%3A//github.com/eigenteam/eigen-git-mirror.git)

KDL源码下载

> git clone [https://github.com/orocos/orocos_kinematics_dynamics.git](https://link.zhihu.com/?target=https%3A//github.com/orocos/orocos_kinematics_dynamics.git)

## 3.解压Eigen3和KDL

Eigen3是一个C++的线性代数模板库，包括矩阵、向量及相关算法。KDL库的底层计算用到Eigen库，因此KDL编译时要加入Eigen的路径。 解压Eigen3和KDL后：

![img](https://pic3.zhimg.com/80/v2-f6fc523d78f68fdd89b7afbcd3656c92_1440w.jpg)



## 4.编译KDL

- 打开orocos_kinematics_dynamics-master/D:\workspcae\orocos_kinematics_dynamics-master\orocos_kdl 目录
- 新建build文件夹
- 打开CMake GUI软件，按下图步骤：①加入源码位置；②加入刚才新建的build文件夹作为生成目录；③点击Configure按钮；④选择编译器，点击完成。

![img](https://pic1.zhimg.com/80/v2-518369fafda9bd62bc2ac605f607b6b8_1440w.jpg)



- 未加入Eigen的路径一般会出现错误，在CMake界面中加入Eigen的路径。按照以下步骤生成Makefile。(建议自己定义安装路径：修改CMAKE_INSTALL_PREFIX)

![img](https://pic1.zhimg.com/80/v2-382018e9f28d678c04851f2f153a8e08_1440w.jpg)

如一切顺利，则出现以下结果：

![img](https://pic3.zhimg.com/80/v2-e1ba6602ac659a971b38173082d1b7f6_1440w.jpg)



- 打开CMD命令提示符，进入已生成Makefile的build的路径，输入make编译KDL库：

![img](https://pic2.zhimg.com/80/v2-6c9ab8dca488d469b22449bbc0dbf969_1440w.jpg)



- 编译完成后，输入make install 安装KDL库：

![img](https://pic2.zhimg.com/80/v2-90ef6bb53485a47bc9dc6f3f1d2dc8ad_1440w.jpg)



- 安装完成后，在CMAKE_INSTALL_PREFIX设置的路径找到以下目录：

![img](https://pic1.zhimg.com/80/v2-67b4d6b579b237c92ab9291644203c5c_1440w.jpg)



- 另外，编译后在build/src目录中生成了liborocos-kdl.dll动态库文件，而make install后并没有安装到目标目录中，可能是cmake配置没配置到。但是动态库非常有用，需要使用liborocos-kdl.dll库时，可以手动复制到目标目录。

[^1]: SaeedB.Niku. 机器人学导论:分析、系统及应用:analysis,systems,applications[M]// 机器人学导论:分析、系统及应用:Analysis, Systems, Applications. 2004. [^2]: 陈坚鸿. 基于Orocos的工业机器人轨迹跟踪研究[D]. 2017.

发布于 2019-05-12 18:37

机器人

机器人运动学

动力学