# gmplib



[https://gmplib.org/](https://gmplib.org/)



The GMP computers are maintained by a single person on a volunteer basis. The ongoing Intel CPU bug debacle with [Meltdown](https://en.wikipedia.org/wiki/Meltdown_(security_vulnerability)), [Spectre](https://en.wikipedia.org/wiki/Spectre_(security_vulnerability)), [Foreshadow](https://en.wikipedia.org/wiki/Foreshadow_(security_vulnerability)), [MDS](https://en.wikipedia.org/wiki/Microarchitectural_Data_Sampling), the jCC/cache-line bug, Fallout, LVI, Portsmash, etc, etc, and the [ME](https://www.theregister.co.uk/2017/11/20/intel_flags_firmware_flaws/) backdoor is making the main GMP server far from as secure as we'd like it to be.

The system which runs this web server as well as mail server, mailing list server, firewall, etc, has an Intel E5-1650 v2 which is affected by most of the bugs/backdoors mentioned above. Please keep that in mind when using the resources here.

Please understand that we don't take security lightly, but that we effectively are [DoS'ed](https://en.wikipedia.org/wiki/Denial-of-service_attack) by sloppy/malicious engineering.




![返回主页](https://www.cnblogs.com/skins/custom/images/logo.gif)

# [Angel_Kitty](https://www.cnblogs.com/ECJTUACM-873284962/)

## 我很弱，但是我要坚强！绝不让那些为我付出过的人失望！

- [博客园](https://www.cnblogs.com/)
- [首页](https://www.cnblogs.com/ECJTUACM-873284962/)
- [新随笔](https://i.cnblogs.com/EditPosts.aspx?opt=1)
- [联系](https://msg.cnblogs.com/send/Angel_Kitty)
- [订阅](javascript:void(0))
- [管理](https://i.cnblogs.com/)

随笔 - 876  文章 - 5  评论 - 2036  阅读 - 298万

# [GMP大法教你重新做人(从入门到实战)](https://www.cnblogs.com/ECJTUACM-873284962/p/8350320.html)





**目录**

- [一、引言](https://www.cnblogs.com/ECJTUACM-873284962/p/8350320.html#_label0)
- [二、用法介绍](https://www.cnblogs.com/ECJTUACM-873284962/p/8350320.html#_label1)
- 三、Linux/Windows下安装配置GMP
  - [1.Linux下安装配置GMP](https://www.cnblogs.com/ECJTUACM-873284962/p/8350320.html#_label2_0)
  - [2.Windows下安装配置GMP](https://www.cnblogs.com/ECJTUACM-873284962/p/8350320.html#_label2_1)
- [四、实例讲解](https://www.cnblogs.com/ECJTUACM-873284962/p/8350320.html#_label3)

 



　　GMP(The GNU Multiple Precision Arithmetic Library)又叫GNU多精度算术库，是一个提供了很多操作高精度的大整数，浮点数的运算的算术库，几乎没有什么精度方面的限制，功能丰富。我刚接触到这个东西的时候是在学习PHP的过程中。GMP的主要目标应用领域是密码学的应用和研究、 互联网安全应用、 代数系统、 计算代数研究等