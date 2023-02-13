# 群晖NAS 篇三：群晖NAS照片备份新姿势：DS photo+DS file+Moments！

[![得意优](https://picx.zhimg.com/a3e4fe705b70b9bea534731b678c75c5_l.jpg?source=172ae18b)](https://www.zhihu.com/people/pi-li-pa-la-89-31)

[得意优](https://www.zhihu.com/people/pi-li-pa-la-89-31)

30 人赞同了该文章



其实我一开始入手NAS的初衷就是照片备份管理。以前照片太多，特别是有了宠物和小朋友以后，照片数量更是直线上升，但是又舍不得删，总感觉都有用，都有价值，这样的后果，就是手机容量居高不下。于是，我开始将手机照片自动备份到百度网盘。后来发现上传是爸爸，下载是儿子以后，果断弃用，花了好几大天下载下来，转换Heic为jpg更是将我的耐心消耗殆尽。最终，照片被存放在电脑，然后我需要定期对手机照片做备份，这样虽然数据安全了，但是手机无法随时随地浏览查看照片，这成了最大痛点。所以，最终选择入手NAS。



## **一、三种照片管理方式**



NAS上手以来，通过不断折腾，我主要尝试过以下三种照片管理方式，并最终选择了DS photo+DS file+Moments这个新姿势！



（一）Moments

通过moments直接备份管理。这种方式存在很多问题：

①无法指定备份路径，系统自动全部备份至Moments目录，无法分类管理。

②虽然支持照片共享，但是仅仅支持共享，并不支持共建，无法实现比如家庭亲子相册的共建共享需求。



（二）DS photo+Moments

针对上述问题，尝试DS photo+Moments，通过DS photo实现自动备份照片，通过Moments的共享照片库功能实现浏览。虽然解决了照片备份路径指定、照片维护管理便捷的问题，但是，仍然存在以下问题：家庭成员超过一个时，虽然可以通过Photo station指定某个账号访问某个相册的权限，但是Moments并不继承该设置。因此通过Moments查看照片时，所有用户都可以查看所有照片，毫无隐私。大家可能会说，弃用Moments，只用DS photo。这确实是一种方法，但是放弃了Moments强大的AI功能对我来说不能容忍，所以只能继续折腾。



（三）DS photo+DS file+Moments

探索DS photo+DS file+Moments。由于Home目录是每个用户的私人文件夹，具有强烈的隐私属性，所以将每个用户的照片备份在该用户的Home>Moments下，便完美地解决了任一用户通过Moments可以查看所有用户的照片的问题。当需要共享家庭照片时，通过DS file管理照片，将共享照片复制到Photo目录下对应相册，并对该相册指定访问权限，则可实现家庭成员共建共享家庭相册。此种新姿势，既解决了多用户照片“被共享”的隐私问题，又支持Moments的AI识别功能，强烈建议大家采用！



下面我们来具体介绍群晖NAS照片备份新姿势：DS photo+DS file+Moments！



## **二、场景一：个人照片管理**



（一）需求



手机照片按照指定路径自动备份，备份以后通过Moments浏览查看，最后可对照片分类管理。



（二）操作方法



01

进入DSM，依次进入File station>Home>Drive>Moments，新建文件夹，如【自动备份】。



![img](https://pic3.zhimg.com/80/v2-732ad4621a4b096b8f080c09597c8f72_1440w.webp)



02

下载安装DS file，打开照片备份，需要验证账户密码，【选择文件夹】选择刚才新建的文件夹，如【自动备份】。特别需要注意的是，强烈建议Ios用户勾选【图片自动转换】，此功能是将苹果专用格式Heic自动转换为Jpg格式。

![img](https://pic3.zhimg.com/80/v2-b6e53a23a90168857425a2c4af441f56_1440w.webp)



03

安装Moments套件，下载安装APP Moments，即可浏览查看照片。

04

对个人照片进行分类管理，进入DSM>File station>Home>Drive>Moments，按自身需求建立文件夹，如【北京旅游】、【上海旅游】等。

![img](https://pic3.zhimg.com/80/v2-339914f6589f342538285297e820847a_1440w.webp)



05

定期对【自动备份】的照片进行整理，按自身分类需求移动照片至上述【北京旅游】、【上海旅游】文件夹。

## **三、场景二：家庭照片共享**



（一）需求



家庭成员将照片共享至同一个相册，并对家庭成员分别控制权限：允许部分或全部家庭成员浏览、上传、管理。



（二）操作方法



01

进入DSM>控制面板>文件共享>用户账号>新增，创建家庭成员账号，此处不能对Photo station分配权限，创建完毕后，请看后续步骤。

![img](https://pic3.zhimg.com/80/v2-a7d11df2b58cd8d547d375076ac05386_1440w.webp)



02

安装Photo station套件，使用管理员账号进入该套件网页管理端，新增相册，如【宝宝】。【权限类型】选择【私人相册】，进入【指定权限】对刚创建的家庭成员账号分配权限。相册创建成功后，将自动放在photo目录下。

![img](https://pic4.zhimg.com/80/v2-01dd3926ae674d7afede3714b0e1ab7f_1440w.webp)

![img](https://pic2.zhimg.com/80/v2-c134ae2503591c092eb2b2ceed8e6a19_1440w.webp)



03

若有新成员加入，可按上述步骤创建账号后，使用管理员账号进入Photo station套件网页版>设置>用户账号>选中账号>编辑>指定权限，管理和分配权限。

![img](https://pic4.zhimg.com/80/v2-f75da23057e03533c2e675f6ce9c563f_1440w.webp)



![img](https://pic4.zhimg.com/80/v2-de570fd37b7bc24f8c2c828eae4dc9c7_1440w.webp)



04

有上传权限的家庭成员各自打开DS file，选择需要共享的照片，复制到Photo目录下刚才的新增相册【宝宝】。

![img](https://pic2.zhimg.com/80/v2-babf89ac3bcc9a4f8ea003eac67d2145_1440w.webp)

05

有浏览权限的家庭成员各自打开DS photo，尽情浏览共享照片吧。

## **四、关于Photo station访问失败**



外网环境，通过DSM直接跳转到Photo station套件网页版，很可能出现问题，跳转不成功，往期的关于外网访问的文章提到过这个问题，这里给大家介绍解决方法。在那篇文章，我们讲到路由器设置了Photo station的端口转发，如我们设置了80——8000，443——4430的转发规则（若有同学不明白这步的，可查阅这篇文章），这样设置以后，我们在登录DS photo时，端口输入8000或者https方式下输入4430，均可以成功登录，这是因为我们指定了8000和4430的端口，并且路由器成功的实现了转发（废话，不然设置干嘛）。但是，通过DSM直接跳转Photo station时，系统会默认端口仍然为80或443，导致在外网环境时无法触发转发规则，导致跳转失败。



解决办法：

01

在局域网环境，通过DSM直接跳转Photo station，或者在外网环境，输入主机名称：【路由器设置的端口号】/photo，如[http://XX.myds.me:8000/photo](https://link.zhihu.com/?target=http%3A//XX.myds.me%3A8000/photo)，点击登录。

![img](https://pic4.zhimg.com/80/v2-837418046310ce2a1bd03cee04996b4f_1440w.webp)

02

设置>常规>路由器端口，输入主机名称或固定IP、HTTP、HTTPS，点击保存。

![img](https://pic3.zhimg.com/80/v2-784b31fa44c3aa3d08106d82c66fb01a_1440w.webp)

03

大功告成！现在可以在内网、外网直接通过DSM成功跳转Photo station。

------

至此，我们实现了如下效果：DS file勤勤恳恳地自动备份手机照片，我们通过Moments随时浏览查看，家庭成员则可随时浏览DS photo的共享相册，完美！

------

好了，本期分享到这里结束了，感谢大家的观看！我们专注分享数码电子，我们是【得意优】，欢迎关注！



发布于 2021-07-06 14:34