# 人脸关键点检测数据库

## 一、人脸关键点检测数据库

（2001年发布）BioID ：约1000幅图像,每个人脸标定20个关键点。

https://www.bioid.com/About/BioID-Face-Database



（2011年发布）LFPW：1132幅图像,每个人脸标定29个关键点

[http://neerajkumar.org/databases/lfpw/](http://neerajkumar.org/databases/lfpw/)



（2011年发布）AFLW：25993幅图像,每个人标定21个关键点
https://lrs.icg.tugraz.at/research/aflw/



（2013年发布）COFW：1852幅图像,每个人脸标定29个关键点
http://www.vision.caltech.edu/xpburgos/



（2014年发布）ICCV13/MVFW ：2500幅图像,每个人脸标定68个关键点
https://sites.google.com/site/junliangxing/codes

（2014年发布）OCFW： 3837幅图像,每个人脸标定68个关键点

https://sites.google.com/site/junliangxing/codes

（2016年发布）300-W ：600幅图像,每个人标定68个关键点

[http://ibug.doc.ic.ac.uk/resources/300-W_IMAVIS/](http://ibug.doc.ic.ac.uk/resources/300-W_IMAVIS/)

​    LFW：http://vis-www.cs.umass.edu/lfw/



（2013年发布）HELEN：348幅图像,每个人标定29个关键点

http://www.f-zhou.com/fa_code.html



（2015年发布）CelebA：10177个人,共202599幅人脸图像，每个人5个关键点
http://mmlab.ie.cuhk.edu.hk/projects/CelebA.html





## 二、人脸关键点检测最新方法调研

1、TCDCN：Learning and Transferring Multi-task Deep Representation for Face Alignment，2014
速度:1.5ms on GTX760,17ms on inter core i5 cpu。  精度：IBUG数据集上9.15%error，优于LBF的11.98%；AFLW数据集上优于cascade CNN；300-W数据集上优于LBF，对难样本效果更好。 CNN卷积神经网络方法。

2、LBF：Face alignment at 3000 fps via regressing local binary features， 2014
速度：PC上至少300fps，最快3000fps。  精度：LFPW数据集error=3.35%，helen数据集达到5.41%； 300-w数据集一般图片error=4.95%，难图片11.98%，处理简单样本效果更好。比一些2013年前较差方法好。   传统方法，决策树。

3、cascade CNN：Deep Convolutional Network Cascade for Facial Point Detection，2013
速度：CPU上0.12s，在gtx1070测试8ms左右。  精度：BioID、LFPW数据集上与2012年之前的方法做对比，没有与最新方法比，测试效果一般。CNN级联结构。

4、MCSR（目前300-w排名第一）：M3 CSR: Multi-view, multi-scale and multi-component cascade，2016
速度：within 50ms on i7 CPU。  精度：IBUG数据集上5.65%，优于TCDCN的9.15%error，优于LBF的11.98%；

5、（目前300-w排名第二）Approaching human level facial landmark localization by deep learning，2016
速度：0.5s on i7 cpu。  精度：在300-w数据集上error:common=3.43,challenge=5.72,full=3.88，明显优于TCDCN、LBF。 CNN级联结构。

6、MDM：Mnemonic Descent Method:A recurrent process applied for end-to-end face alignment， 2016
速度：不详。    精度：300W数据集上，threshold=0.08时，51点error=4.2%，68点error=6.8%。 效果优于Face++,yan et al,CFSS。    CNN+RNN 深度学习方法

7、Face++：Extensive facial landmark localization with coarse-to-fine convolutional network cascade，2013
速度：不详。    精度：300-w数据集上，threshold=0.08时，51点error=5%，68点error=8%，没有与其他方法对比，此方法效果稍微差点。

8、CFSS：Face Alignment by Coarse-to-Fine Shape Searching， 2015
速度：25fps on i5 cpu。    精度：在300w数据集上，效果优于LBF和2013年之前的很多方法。在LFPW，Helen数据集上比较结果类似。    传统方法

9、Unconstrained Face Alignment via Cascaded Compositional Learning，2016

速度：PC上cpu实现350FPS。    精度：AFLW上优于CFSS，LBF。  使用决策树。

10、DRDA：Occlusion-free Face Alignment: Deep Regression Networks Coupled with De-corrupt AutoEncoders

速度：不详。      精度：IBUG数据集上，和很多较差方法做对比，效果稍微优于LBF，和我上诉总结的方法没有对比。





11、Wing Loss for RobustFacial Landmark Localisation with Convolutional Neural Networks.

速度：cpu 100/15/5 FPS  精度： 300w，common: 3.27,challenge: 7.18, Full: 4.04. 