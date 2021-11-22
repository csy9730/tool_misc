# 瑞芯微RK3588规格公布，8K视频、6 TOPS NPU、高达32GB内存

原文链接：[Rockchip RK3588 specifications revealed – 8K video, 6 TOPS NPU, PCIe 3.0, up to 32GB RAM](https://www.cnx-software.com/2020/11/26/rockchip-rk3588-specifications-revealed-8k-video-6-tops-npu-pcie-3-0-up-to-32gb-ram/) 由Jean-Luc Aufranc撰写。

[Rockchip RK3588](https://www.cnx-software.com/2020/02/01/rockchip-rk3566-rk3588-rv1109-socs-coming-in-2020-based-on-rockchip-processor-roadmap/#rockchip-rk3588)是国内无晶圆厂芯片设计公司瑞芯微（Rockchip）2020年发布的一款处理器，它也是互联网行业内最受期待的处理器之一。该八核处理器具有四个Cortex-A76内核、四个Cortex-A55内核和一个 NPU 和 8K 视频解码支持。

我们一起来看看这款如此受欢迎处理器的详细信息。

![RK3588宣传海报](https://cnx-software.cn/wp-content/uploads/2021/05/RK3588%E5%AE%A3%E4%BC%A0%E6%B5%B7%E6%8A%A5.jpg)RK3588 的宣传海报

这意味着我们现在有更详细的岩石芯片 RK3588 规格：

- CPU-4个Cortex-A76和4个Cortex-A55内核，采用动态配置
- GPU–ARM Mali “Odin” MP4 GPU
- AI加速器 – 一个6 TOPS的3.0加速器（Neural Processing Unit）
- VPU-支持8K@30视频编码以及8K@60视频解码
- 内存 I/F – 采用LPDDR4x/LPDDR5控制器，最高可达 32GB内存
- 存储-eMMC 5.1、SDIO、SATA 3.0（多路PCIe 2.0复用）
- 视频输出
  - 双HDMI 2.1/eDP高达8Kp60或4Kp120
  - 高达 4Kp60的双显示端口
  - 双米皮 DSI 输出
  - 最多四个独立显示器
- 相机-48M（2x 24M）ISP，支持HDR和3D NR；多摄像头输入
- 音频–支持多MIC阵列
- 网络–双千兆以太网接口
- USB-2个USB 3.1TypeC接口，2个USB0接口
- PCIe-4条PCIe 3.0和3路PCIe 2.0（与多路SATA复用）
- 制造工艺–8nm LP

![RK3599处理器规格](https://cnx-software.cn/wp-content/uploads/2021/05/RK3599%E5%A4%84%E7%90%86%E5%99%A8%E8%A7%84%E6%A0%BC.jpg)RK3599处理器规格

该公司提供了对安卓、Linux和“国内操作系统”的支持。值得注意的是，该处理器的GPU已经从“Natt”系列更改为“Odin”系列，且瑞芯微并没有使用像芯原 VeriSilicon NPU IP 这样的第三方设计，而是特意为 RK3588 设计了自己的 NPU IP。

RK3588 的规格确实很让人印象很深刻，处理器出现在了 Arm 计算机、智能显示器、边缘计算和 AIoT 解决方案、Arm 服务器、高性能平板电脑、网络录像机、虚拟现实耳机以及需要多个摄像头和显示器等多种应用程序当中。不过，大家应该也注意到，RK3588并不支持UFS，而是依赖于速度较慢的eMMC 5.1 Flash接口存储。