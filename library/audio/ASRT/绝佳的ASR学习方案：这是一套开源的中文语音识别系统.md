# 绝佳的ASR学习方案：这是一套开源的中文语音识别系统

[![机器之心](https://pic2.zhimg.com/v2-dd115d399e55c37e3312c8ee4713890e_xs.jpg?source=172ae18b)](https://www.zhihu.com/org/ji-qi-zhi-xin-65)

[机器之心](https://www.zhihu.com/org/ji-qi-zhi-xin-65)[](https://www.zhihu.com/topic/20054793)



数学话题下的优秀答主

> 语音识别目前已经广泛应用于各种领域，那么你会想做一个自己的语音识别系统吗？这篇文章介绍了一种开源的中文语音识别系统，读者可以借助它快速训练属于自己的中文语音识别模型，或直接使用预训练模型测试效果。所以对于那些对语音识别感兴趣的读者而言，这是一个学习如何搭建 ASR 系统的极好资料。
ASRT 是一套基于深度学习实现的[语音识别](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/s%3F__biz%3DMzA3MzI4MjgzMw%3D%3D%26mid%3D2650756900%26idx%3D2%26sn%3D6676da5421840205c93b0f43f62e79e6%26chksm%3D871a935ab06d1a4c670f71bb55eb21369f5ccdc7716f215d1fc71806faf391e9f223f73cce92%26token%3D844319223%26lang%3Dzh_CN)系统，全称为 Auto Speech Recognition Tool，由 AI 柠檬博主开发并在 GitHub 上开源（GPL 3.0 协议）。本项目声学模型通过采用[卷积神经网络](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/s%3F__biz%3DMzA3MzI4MjgzMw%3D%3D%26mid%3D2650756900%26idx%3D2%26sn%3D6676da5421840205c93b0f43f62e79e6%26chksm%3D871a935ab06d1a4c670f71bb55eb21369f5ccdc7716f215d1fc71806faf391e9f223f73cce92%26token%3D844319223%26lang%3Dzh_CN)（CNN）和连接性时序分类（CTC）方法，使用大量中文语音数据集进行训练，将声音转录为中文拼音，并通过[语言模型](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/s%3F__biz%3DMzA3MzI4MjgzMw%3D%3D%26mid%3D2650756900%26idx%3D2%26sn%3D6676da5421840205c93b0f43f62e79e6%26chksm%3D871a935ab06d1a4c670f71bb55eb21369f5ccdc7716f215d1fc71806faf391e9f223f73cce92%26token%3D844319223%26lang%3Dzh_CN)，将拼音序列转换为中文文本。基于该模型，作者在 Windows 平台上实现了一个基于 ASRT 的语音识别应用软件它同样也在 GitHub 上开源了。

- ASRT 项目主页：[https://asrt.ailemon.me](https://link.zhihu.com/?target=https%3A//asrt.ailemon.me)
- GitHub 项目地址：[https://github.com/nl8590687/ASRT_SpeechRecognition](https://link.zhihu.com/?target=https%3A//github.com/nl8590687/ASRT_SpeechRecognition)

这个开源项目主要用于语音识别的研究，作者希望它可以一步步发展为极高准确率的 ASR 系统。此外，因为模型和训练代码都是开源的，所以能节省开发者很多时间。同样，如果开发者想要根据需求修改这个项目，那也非常简单，因为  ASRT 的代码都是经过高度封装的，所有模块都是可以自定义的。如下展示了该项目的一些特征：

![img](https://pic2.zhimg.com/80/v2-d07b3a91866ad468f6a9b4adbfed626d_720w.jpg)

**系统流程**

特征提取：将普通的 wav 语音信号通过分帧加窗等操作转换为神经网络需要的二维频谱图像信号，即语谱图。

![img](https://pic4.zhimg.com/80/v2-75fbe1ec1aec5413832dff6019ec083b_720w.jpg)

声学模型：基于 Keras 和 TensorFlow 框架，使用这种参考了 VGG 的深层的卷积神经网络作为网络模型，并训练。

![img](https://pic3.zhimg.com/80/v2-a94f14d9d344a1eb15f4e03d9dc93df6_720w.jpg)

CTC 解码：在语音识别系统的声学模型输出中，往往包含了大量连续重复的符号，因此，我们需要将连续相同的符号合并为同一个符号，然后再去除静音分隔标记符，得到最终实际的语音拼音符号序列。

![img](https://pic3.zhimg.com/80/v2-20f535aaf16be95d291bedb796fbc66a_720w.jpg)

语言模型：使用统计语言模型，将拼音转换为最终的识别文本并输出。拼音转文本本质被建模为一条隐含马尔可夫链，这种模型有着很高的准确率。

**使用流程**

如果读者希望直接使用预训练的中文语音识别系统，那么直接下载 Release 的文件并运行就好了：

下载地址：[https://github.com/nl8590687/ASRT_SpeechRecognition/releases/tag/v0.4.2](https://link.zhihu.com/?target=https%3A//github.com/nl8590687/ASRT_SpeechRecognition/releases/tag/v0.4.2)

如果读者希望修改某些模块，或者在新的数据集上进行训练，那么我们可以复制整个项目到本地，再做进一步处理。首先我们通过 Git 将本项目复制到本地，并下载训练所需要的数据集。作者在项目 README 文件中提供了两个数据集，即清华大学 THCHS30  中文语音数据集和 AIShell-1 开源版数据集。

```text
$ git clone https://github.com/nl8590687/ASRT_SpeechRecognition.git
```

THCHS30 和 ST-CMDS 国内下载镜像：[http://cn-mirror.openslr.org/](https://link.zhihu.com/?target=http%3A//cn-mirror.openslr.org/)

在下载数据集后，我们需要将 datalist 目录下的所有文件复制到 dataset 目录下，也就是将其与数据集放在一起

```text
$ cp -rf datalist/* dataset/
```

在开始训练前，我们还需要安装一些依赖库：

- python_speech_features
- TensorFlow
- Keras
- wave

当然，其它如 NumPy、Matplotlib、Scipy 和 h5py 等常见的科学计算库也都是需要的。一般有这些包后，环境应该是没什么问题的，有问题也可以根据报错安装对应缺少的库。

训练模型可以执行命令行：

```text
$ python3 train_mspeech.py
```

测试模型效果可以运行：

```text
$ python3 test_mspeech.py
```

测试之前，请确保代码中填写的模型文件路径存在。最后，更多的用法和特点可以查看原 GitHub 项目和文档。



*![img](https://pic1.zhimg.com/80/v2-18cc987d5f379a82f1208b6d90722318_720w.jpg)*





发布于 2019-02-11 23:19

[语音识别](https://www.zhihu.com/topic/19560846)

[自然语言处理](https://www.zhihu.com/topic/19560026)

[人工智能](https://www.zhihu.com/topic/19551275)

### 文章被以下专栏收录