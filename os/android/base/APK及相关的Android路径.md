## [APK及相关的Android路径](https://www.cnblogs.com/kekec/p/13626063.html)

APK(Android package，[wiki](https://en.wikipedia.org/wiki/Android_application_package) [chs](https://zh.wikipedia.org/wiki/APK))：android安装包，由[aapt](https://androidaapt.com/)（Android Assert Packaging Tool，已集成到[build-tools](https://developer.android.com/studio/releases/build-tools)工具集中）把AndroidManifest.xml、资源文件、lib动态链接库、dex（Dalvik二进制字节码）等归档成的zip压缩包。

![img](https://img2020.cnblogs.com/blog/78946/202009/78946-20200907180208489-1607564729.png)

**assets**：对应项目工程asset目录下的文件，可以使用AssetManager获取   注：其下的main.obb.png为一个压缩方式为仅存储的标准zip文件

**lib**：包含适用于不同处理器的第三方动态链接库（*.so），这里边可以有多个子目录。如：armeabi、armeabi-v7a、 arm64-v8a,、x86,、x86_64以及mips

**META-INF**：存放签名证书等信息；其中包含两个签名文件（CERT.SF和CERT.RSA）和一个manifest文件（MANIFEST.MF）

​    jdk1.8.0_77\bin\keytool.exe -printcert -file %apkdir%\CERT.RSA // 查看当前apk的签名信息

**res**：包含那些没有被编译到resources.arsc的资源（如：应用图标、字符串表等）

**AndroidManifest.xml**：二进制格式的清单文件

**classes\*.dex**：Dalvik EXcutable file，Dalvik虚拟机执行程序，java文件先编译为class文件，然后打包成dex二进制字节码文件。一个APK中有多个dex文件。

**resources.arsc**：存储编译好的资源，包括项目工程中的res/values目录里的xml文件，它们都被编译成二进制格式，也包括一些路径，指向那些没有被编译的资源，比如layout文件和图片

 

## **Android系统目录结构**

- /init           系统启动文件

- **/bin**          常用的系统本地命令（二进制） 如：du、ls、mv等

- /system

  - build.prop    系统设置和变更属性

  - **app**        安装的系统应用所在的目录

  - **bin**         常用的系统本地命令（二进制） 如：ps、cp、rm等

  - etc       

      系统配置文件

    - hosts     用于配置IP或域名的重定向文件**
      **

  - **font**        字体目录

  - **framework**   Java平台架构核心库，jar包和odex优化的文件

  - **lib**         32位系统底层共享库，.so库文件

  - lib64

    ​       64位系统底层共享库，.so库文件

    - egl
      - libGLES_android.so
    - libart-compiler.so
    - libart-dexlayout.so
    - libart.so
    - libc++.so
    - libc.so
    - libstdc++.so
    - lib_malloc_debug.so
    - lib_malloc_hooks.so
    - libEGL.so
    - libGLESv1_CM.so
    - libGLESv2.so
    - libGLESv3.so
    - ... ...

  - **xbin**        不常用的系统管理工具，相当于linux的/sbin

  - media

    - audio

      　　铃声，提示音等音频文件， .ogg

      - **notifications**   通知
      - **ui**          界面
      - **alarms**       警告
      - **ringtones**     铃声

  - usr         

      用户文件夹，包含共享、键盘布局、时间区域

    - **keychars**
    - **keylayout**
    - **share**
    - **srec**     配置
    - ......

  - vendor     

     

    厂商文件

    - build.prop
    - **app**    厂商自带应用所在目录
    - **bin**    厂商自带命令工具
    - **etc**
    - **lib**
    - lib64
      - egl
        - eglSubDriverAndroid.so
        - libGL_adreno.so
        - libGLESv1_CM_adreno.so
        - libGLESv2_adreno.so
        - libq3dtools_adreno.so
        - libq3dtools_esx.so
        - libQTapGLES.so　　
      - libjson.so
      - ... ...

- */etc* -->  软链接指向 /system/etc

- */vendor* --> 软链接指向 /system/vendor

- **/dev**            存放设备节点文件

- **/proc**          全局系统信息

- /data

  　　        用户软件和各种数据

  - **local/tmp**　　临时目录，无权限要求
  - **app**        普通程序安装目录
  - data
    - <package_name>
      - **files**            Context.getFilesDir() ，Context.openFileOutput() 获取的目录，应用安装目录下
      - **cache**         Context.getCacheDir()  获取的目录，应用安装目录下，系统会自动在内存不足或目录大小达到特定数值时自动清理。
      - **shared_pref**     Context.getSharedPreferences() 建立的preferences文件（xml）存放目录
  - **anr**         应用发生ANR（Applicaiton is Not Responding）时，Android将问题点的堆栈写入到traces.txt文件中
  - **tombstones**   应用crash时，会将各线程的堆栈写到tombstone_xx文件中
  - **property**     其中persist.sys.timezone记录系统时区

- /sdcard

   

   --> 软链接  SD卡的FAT32文件系统挂载到此目录

  - Android

    - data

      - <package_name>

          应用的额外数据，应用卸载时自动删除。

        - **files**   Context.getExternalFilesDir()获取的目录。设置->应用->具体应用详情-> 清除数据  操作对象就是这个目录。
        - **cache**   Context.getExternalCacheDir()获取的缓存目录。设置->应用->具体应用详情-> 清除缓存  操作对象就是这个目录。

可在Android Studio的View菜单 -- Tool Windows -- Device File Explorer面板中查看手机上整个文件目录（手机无需root  更多信息详见[这里](https://developer.android.com/studio/debug/device-file-explorer)）

![img](https://img2020.cnblogs.com/blog/78946/202009/78946-20200910155727027-665912886.png)

 注：文件夹图标的右上角带箭头为一个软链接，右下角带问号的为一个文件

 

## **内部存储（Internal Storage）**

在手机内部，属于手机自带存储空间的一部分

/data/app // 应用程序安装的目录。安装时，系统的PackageManagerService（PMS）进程会把apk文件复制到该目录

![img](https://img2020.cnblogs.com/blog/78946/202009/78946-20200907170655092-377701256.png)

\1. com.tencent.mf.test1-S72Tv4IGEow5LtbwxPQHpQ==   // 字符串S72Tv4IGEow5LtbwxPQHpQ是随机字符串，每次安装都会变化

\2. base.apk为原始的Android安装包。app运行时的资源从该文件中读取。

\3. 在安装apk时，PMS会将apk中的so动态链接库释放到/data/app/com.tencent.mf.test1-S72Tv4IGEow5LtbwxPQHpQ==/lib/arm64中

  游戏so动态链接库的路径搜索路径依次为：/data/app/com.tencent.mf.test1-S72Tv4IGEow5LtbwxPQHpQ==/lib/arm64, /data/app/com.tencent.mf.test1-S72Tv4IGEow5LtbwxPQHpQ==/base.apk!/lib/arm64-v8a, /system/lib64, /vendor/lib64, /product/lib64

\4. 首次运行app时，会将apk中的classes*.dex编译释放到/data/app/com.tencent.mf.test1-S72Tv4IGEow5LtbwxPQHpQ==/oat/arm64中，会生成出3个文件：base.vdex、base.odex、base.art

  .vdex：未压缩DEX 代码，以及一些旨在加快验证速度的元数据（省去重新校验apk中dex文件合法性的过程 ）。Android 8引入。
  .odex：对于dalvik虚拟机，存放的是JIT后的优化后的字节码（Optimized Dalvik EXcutable file）；对于AOT Runtime，存放的是经过AOT（Ahead Of Time）编译后的本地机器码（即：oat文件，一种私有的ELF文件格式）。

  注1：为了保证安装速度，在安装时并没有AOT；而是当app启动运行一小段时间，收集了足够多的jit 热点方法信息时，

​       Android会在后台重新进行dex2oat（该文件在/system/bin/dex2oat，是Android Art Runtime的重要模块）, 将热点函数（Hot Code）编译成odex本地机器码

  注2：odex + vdex = 全部java源码。随着更多的vdex的java代码被AOT成odex，其size会逐渐变小

  .art (可选)：包含APK中列出的某些字符串和类的 ART 内部表示，记录app启动热点函数相关地址，用于加快app启动速度。

 

/data/data // 该目录存放应用程序的私有数据

对于设备中每一个安装的 App，系统都会在内部存储空间的/data/data 目录下以应用包名为名字自动创建与之对应的文件夹。

用户卸载 App 时，系统自动删除/data/data 目录下对应包名的文件夹及其内容。

![img](https://img2020.cnblogs.com/blog/78946/202009/78946-20200907235537546-1437562245.png)

/data/data/包名/cache： 存放的 APP 的缓存信息

```
context.getCacheDir(); // 返回/data/data/包名/cache目录路径
```

/data/data/包名/databases： 存放 APP 的数据库信息

```
context.getDataDir(); // 返回/data/data/包名/databases目录路径
context.getDatabasePath(name); // 获取指定数据库对象
context.deleteDatabase(name); // 删除指定数据库对象
```

/data/data/包名/files： 存放 APP 的文件信息

```
context.getFilesDir(); // 返回/data/data/包名/files目录路径
context.deleteFile(name); // 删除指定文件对象
context.fileList(); // 查询所有文件对象
```

/data/data/包名/shared_prefs： 存放 APP 内的 SharedPreferences

```
context.getSharedPreferences(name,mode) //返回指定的SharedPreferences对象
context.deleteSharedPreferences(name) // 删除指定的SharedPreferences
```

 

一些内部存储的根目录

```
Environment.getDataDirectory(); // 返回/data目录
Environment.getDownloadCacheDirectory(); // 返回/cache目录
Environment.getRootDirectory(); // 返回/system目录
```

 

## **外部存储（External Storage）**

非root下，只要是能看得到，都是外部存储

该存储可能是可移除的存储介质（如：SD 卡）或内部（不可移除）存储。 保存到外部存储的文件是全局可读取文件。当用USB连接到计算机并以传输文件后，可由用户修改这些文件。

外部存储在Android 文件系统中是/sdcard目录（只是一个快捷方式），真正的目录是 /storage/emulated/0 文件夹

/sdcard -> /storage/self/primary -> /mnt/user/0/primary -> /storage/emulated/0

注1：对于不同版本的Android系统，/sdcard指向的真正目录有一些不同。

注2：Android设备一般都有内置 SD 卡，有一些设备同时也提供外置 SD 卡接口（用于插入的外置内存卡，其对应的路径形如：/storage/AFE0-2E94）



```
Environment.getExternalStorageDirectory();  //  返回/storage/emulated/0目录

Environment.getExternalStoragePublicDirectory(DIRECTORY_ALARMS);  //  返回/storage/emulated/0/Alarms目录
Environment.getExternalStoragePublicDirectory(DIRECTORY_DCIM);  //  返回/storage/emulated/0/DCIM目录
Environment.getExternalStoragePublicDirectory(DIRECTORY_DOWNLOADS);  //  返回/storage/emulated/0/Download目录
Environment.getExternalStoragePublicDirectory(DIRECTORY_MOVIES);  //  返回/storage/emulated/0/Movies目录
Environment.getExternalStoragePublicDirectory(DIRECTORY_MUSIC);  //  返回/storage/emulated/0/Music目录
Environment.getExternalStoragePublicDirectory(DIRECTORY_NOTIFICATIONS);  //  返回/storage/emulated/0/Notifications目录
Environment.getExternalStoragePublicDirectory(DIRECTORY_PICTURES);  //  返回/storage/emulated/0/Pictures目录
Environment.getExternalStoragePublicDirectory(DIRECTORY_PODCASTS);  //  返回/storage/emulated/0/Podcasts目录
Environment.getExternalStoragePublicDirectory(DIRECTORY_RINGTONES);  //  返回/storage/emulated/0/Ringtones目录
```



 

/sdcard/Android/data/包名  // App外部存储私有目录

```
context.getExternalFilesDir();  //外部存储私有目录/sdcard/Android/data/包名/files  UE4的FString GExternalFilePath全局变量即为该目录   一般存储长时间保存的数据   对应“设置”->“应用”-> “应用详情”里面的“清除数据”选项
context.getExternalCacheDir(); //外部存储私有目录/sdcard/Android/data/包名/cache  一般存储临时缓存数据   对应“设置”->“应用”-> “应用详情”里面的“清除缓存”选项
```

注：GCloud的log就放在/sdcard/Android/data/包名/cache/GCloudSDKLog/GCloud目录中

默认情况下，系统并不会自动创建外部存储空间的应用私有目录。开发人员需在需要时，通过 SDK 提供的 API 创建该目录文件夹和操作文件夹内容

当用户卸载 App 时，系统也会自动删除外部存储空间下的对应 App 私有目录文件夹及其内容，不会留下垃圾。

 

/sdcard/Android/obb/包名  // App外部存储obb目录

```
context.getObbDir(); // 返回App的外部存储obb目录
```

 

/sdcard/UE4Game  // UE4Game外部存储目录

在UE4Game外部存储目录中，Test1项目的目录结构如下：

![img](https://img2020.cnblogs.com/blog/78946/202009/78946-20200908015531059-1412554292.png)

 

## **APK安装的4种方式**

① 系统应用安装：开机时加载系统的APK和应用，没有安装界面

② 网络下载应用安装：通过各种market应用完成，没有安装界面

③ ADB工具安装：即通过Android的SDK开发tools里面的adb.exe程序安装，没有安装界面 

注1：对应的window为：com.miui.securitycenter/com.miui.permcenter.install.AdbInstallActivity

注2：需要在【开发者选项】中打开【USB安装】

注3：小米10手机可通过如下设置来关闭“USB安装提示”的确认  -- **step1**：【开发者选项】中【关闭MIUI 优化】 **step2**：重启手机   **step3**：【应用设置】--【授权管理】，右上角设置里面，关闭【USB安装管理】

![img](https://img2020.cnblogs.com/blog/78946/202010/78946-20201031140444968-112627007.png)

 

④ 通过第三方应用来安装：通过SD卡里的APK文件安装(比如双击APK文件触发)，有安装界面，系统默认已经安装了一个安装卸载应用的程序（packageinstaller.apk）

![img](https://img2020.cnblogs.com/blog/78946/202012/78946-20201230094706269-1655524454.png)

 

如果apk包超过2GB，在某些手机上会安装失败（例如：oppo A5）。  注：小米10上能安装成功

 

## **APK安装过程**

\1. 拷贝apk文件到指定目录

在Android系统中，apk安装文件是会被保存起来的，默认情况下，用户安装的apk首先会被拷贝到 /data/app 目录下。/data/app目录是用户有权限访问的目录，在安装apk的时候会自动选择该目录存放用户安装的文件。

而系统出厂的apk文件则被放到了 /system 分区下,包括 /system/app，/system/vendor/app，以及 /system/priv-app 等等，该分区只有Root权限的用户才能访问，这也就是为什么在没有Root手机之前，我们无法删除系统出厂的app的原因了。

\2. 解压apk，拷贝文件，创建应用的数据目录

apk在安装的时候，会将app的依赖的第三方动态链接库拷贝到/data/app/包名-XXXXXXXXXXXXXX==/lib/平台名的目录中。

然后，在/data/data/目录下创建应用程序的数据目录（以应用的包名命名），存放应用的相关数据，如数据库、xml文件、cache、二进制的so动态库等等。

\3. 解析apk的AndroidManifinest.xml文件并写入/data/system/packages.xml中

/data/system/packages.xml类似于Windows的注册表，这个文件是在解析apk时由writeLP()创建的，里面记录了系统的permissions，以及每个apk的name,codePath,flags,ts,version,uesrid等信息。

这些信息主要通apk的AndroidManifest.xml解析获取，解析完apk后将更新信息写入这个文件并保存，下次开机直接从里面读取相关信息添加到内存相关列表中。当有apk升级，安装或删除时会更新这个文件。



```
<package name="com.tencent.mf.test1" codePath="/data/app/com.tencent.mf.test1-S72Tv4IGEow5LtbwxPQHpQ==" nativeLibraryPath="/data/app/com.tencent.mf.test1-S72Tv4IGEow5LtbwxPQHpQ==/lib" primaryCpuAbi="arm64-v8a" publicFlags="940097094" privateFlags="0" ft="173e7953470" it="173e795b2e4" ut="173e795b2e4" version="1" userId="10815" installer="com.miui.packageinstaller">
    <sigs count="1" schemeVersion="2">
        <cert index="34" key="3082033d30820225a003020102020425c2be86300d06092a864886f70d01010b0500304e310b300906035504061302636e310b3009060355040813026764310b300906035504071302737a310b3009060355040a13026d66310b3009060355040b13026d66310b3009060355040313026d663020170d3230303130363037343934385a180f32323933313032313037343934385a304e310b300906035504061302636e310b3009060355040813026764310b300906035504071302737a310b3009060355040a13026d66310b3009060355040b13026d66310b3009060355040313026d6630820122300d06092a864886f70d01010105000382010f003082010a0282010100b4455215e09e7cdb7830cebe51c0d79e6f5cb22e96d7ce11f3d1f40e1ef43be245f49fbabb1af8efeddb823dc7ca1273724421c478a315e01b57f69a3d642c062bd879e096904fb379692c6d62cb032b14d6ed687a53b620dcf6ddb925fea65bdad3eff2244786d3b22dbfb2e7cc77424336048c852b7e85bdf41d5a05da231528ae3bfebb6752a92cf895073b38c3b43e1f9f6d217d24bab868575b36d7efd29739ad5b34b4d7f53a9c2cbe2b8db349f730b0cda090b91e57a54cdc5803577ac84159f7144a69902f12bd8da4986a85aab9020bab076f5f2254fd57c75c3c8aaeb4b4eda6ba9c9369e08e77f4f99c801e8819c341743de17dce558470e5b19f0203010001a321301f301d0603551d0e0416041491e0d5be16fcfcfa80e39b370a70ec05236828ff300d06092a864886f70d01010b05000382010100919b40fc021831a196726201e528c4a3ceefce44890ec9c07e543b757e0a0fde0c1230c34e3883104ff7e3cac4d0fcf42dbb4cefaaf97853e04313d1a611b5198b8d969c00b041bb2de8484b4140c5d80a7bdcbe66bd03fbb37c78b794078fc5d512b0298144864691d01cbd12d3f052548c83cc6d76c62379ce1fe7b48c24af4f1cf0ddf35faa4f833ab556c60d1793a432cfb64e475fe01dad59417d1b6a3f97f24de881dc65842e361e2074edf23d80228ce5f242bd485dc60b43999c2328e11608376a60eacc9a0228356aa008a1d95c57d3526591dbd352aa46b06f9c21f90e1967a65ccd70859d9a420ee5b0cb62ca7ef18c4fa0da8534577e7677f7b8" />
    </sigs>
    <perms>
        <item name="android.permission.MODIFY_AUDIO_SETTINGS" granted="true" flags="0" />
        <item name="android.permission.BLUETOOTH" granted="true" flags="0" />
        <item name="android.permission.INTERNET" granted="true" flags="0" />
        <item name="com.android.vending.CHECK_LICENSE" granted="true" flags="0" />
        <item name="android.permission.BLUETOOTH_ADMIN" granted="true" flags="0" />
        <item name="android.permission.CHANGE_WIFI_STATE" granted="true" flags="0" />
        <item name="android.permission.ACCESS_NETWORK_STATE" granted="true" flags="0" />
        <item name="android.permission.VIBRATE" granted="true" flags="0" />
        <item name="android.permission.ACCESS_WIFI_STATE" granted="true" flags="0" />
        <item name="android.permission.WAKE_LOCK" granted="true" flags="0" />
    </perms>
    <proper-signing-keyset identifier="577" />
</package>
```



\4. 显示icon图标

Launcher应用程序负责从PackageManagerService服务中把这些安装好的App取出来，并以快捷图标的方式在桌面上展现出来。

如小米10上的Launcher window为：com.miui.home/.launcher.Launcher

 

## **SIM卡**

SIM卡即电话芯片卡，对应某个手机号，上面也能存放一些个人隐私数据：如联系人、短信等。

第三方App必须申请相应的权限才能访问SIM卡上数据。

 

## 用appt查询apk包相关信息

C:\Users\kekec\Downloads>E:\NVPACK\android-sdk-windows\build-tools\27.0.3\aapt.exe dump badging UAGame-arm64-es2_v0.1.0.7294.0_469833.apk



```
package: name='com.tencent.mf.uam' versionCode='469833' versionName='0.1.0.7294' platformBuildVersionName=''
install-location:'internalOnly'
sdkVersion:'21'
targetSdkVersion:'26'
uses-permission: name='android.permission.INTERNET'
uses-permission: name='android.permission.WRITE_EXTERNAL_STORAGE'
uses-permission: name='android.permission.ACCESS_NETWORK_STATE'
uses-permission: name='android.permission.WAKE_LOCK'
uses-permission: name='com.android.vending.CHECK_LICENSE'
uses-permission: name='android.permission.ACCESS_WIFI_STATE'
uses-permission: name='android.permission.MODIFY_AUDIO_SETTINGS'
uses-permission: name='android.permission.VIBRATE'
uses-permission: name='com.android.vending.BILLING'
uses-permission: name='com.qti.permission.PROFILER'
supports-gl-texture:'GL_KHR_texture_compression_astc_ldr'
uses-permission: name='android.permission.READ_PHONE_STATE'
uses-permission: name='android.permission.RECORD_AUDIO'
uses-permission: name='android.permission.BLUETOOTH'
uses-permission: name='android.permission.BLUETOOTH_ADMIN'
uses-permission: name='android.permission.CHANGE_WIFI_STATE'
uses-permission: name='android.permission.ACCESS_FINE_LOCATION'
uses-permission: name='android.permission.GET_TASKS'
uses-permission: name='android.permission.RESTART_PACKAGES'
uses-permission: name='android.permission.SYSTEM_ALERT_WINDOW'
uses-permission: name='android.permission.WRITE_SETTINGS'
uses-permission: name='android.permission.MOUNT_UNMOUNT_FILESYSTEMS'
uses-permission: name='android.permission.READ_EXTERNAL_STORAGE'
uses-permission: name='android.permission.INTERNET'
uses-permission: name='android.permission.ACCESS_NETWORK_STATE'
uses-permission: name='android.permission.ACCESS_WIFI_STATE'
uses-permission: name='android.permission.READ_PHONE_STATE'
uses-permission: name='android.permission.READ_EXTERNAL_STORAGE'
uses-permission: name='android.permission.FOREGROUND_SERVICE'
uses-permission: name='ACCESS_NETWORK_STATE'
uses-permission: name='android.permission.REQUEST_INSTALL_PACKAGES'
uses-permission: name='com.tencent.mf.uam.permission.XGPUSH_RECEIVE'
uses-permission: name='android.permission.RECEIVE_USER_PRESENT'
uses-permission: name='android.permission.READ_LOGS'
uses-permission: name='android.permission.DISABLE_KEYGUARD'
uses-permission: name='android.permission.BROADCAST_STICKY'
uses-permission: name='android.permission.REORDER_TASKS'
uses-permission: name='android.permission.CHANGE_WIFI_MULTICAST_STATE'
uses-permission: name='android.permission.CHANGE_NETWORK_STATE'
uses-permission: name='com.tencent.mf.uam.permission.MIPUSH_RECEIVE'
uses-permission: name='com.meizu.flyme.push.permission.RECEIVE'
uses-permission: name='com.tencent.mf.uam.push.permission.MESSAGE'
uses-permission: name='com.meizu.c2dm.permission.RECEIVE'
uses-permission: name='com.tencent.mf.uam.permission.C2D_MESSAGE'
uses-permission: name='com.tencent.mf.uam.permission.PROCESS_PUSH_MSG'
uses-permission: name='com.tencent.mf.uam.permission.PUSH_PROVIDER'
uses-permission: name='com.coloros.mcs.permission.RECIEVE_MCS_MESSAGE'
uses-permission: name='com.heytap.mcs.permission.RECIEVE_MCS_MESSAGE'
uses-permission: name='com.huawei.appmarket.service.commondata.permission.GET_COMMON_DATA'
application-label:'可可西'
application-label-af:'可可西'
application-label-am:'可可西'
application-label-ar:'可可西'
application-label-as:'可可西'
application-label-az:'可可西'
application-label-be:'可可西'
application-label-bg:'可可西'
application-label-bn:'可可西'
application-label-bo-CN:'可可西'
application-label-bs:'可可西'
application-label-ca:'可可西'
application-label-cs:'可可西'
application-label-da:'可可西'
application-label-de:'可可西'
application-label-el:'可可西'
application-label-en:'可可西'
application-label-en-AU:'可可西'
application-label-en-CA:'可可西'
application-label-en-GB:'可可西'
application-label-en-IN:'可可西'
application-label-en-US:'可可西'
application-label-en-XC:'可可西'
application-label-es:'可可西'
application-label-es-US:'可可西'
application-label-et:'可可西'
application-label-eu:'可可西'
application-label-fa:'可可西'
application-label-fi:'可可西'
application-label-fr:'可可西'
application-label-fr-CA:'可可西'
application-label-gl:'可可西'
application-label-gu:'可可西'
application-label-hi:'可可西'
application-label-hr:'可可西'
application-label-hu:'可可西'
application-label-hy:'可可西'
application-label-in:'可可西'
application-label-is:'可可西'
application-label-it:'可可西'
application-label-iw:'可可西'
application-label-ja:'可可西'
application-label-jv-Latn:'可可西'
application-label-ka:'可可西'
application-label-kk:'可可西'
application-label-km:'可可西'
application-label-kn:'可可西'
application-label-ko:'可可西'
application-label-ky:'可可西'
application-label-lo:'可可西'
application-label-lt:'可可西'
application-label-lv:'可可西'
application-label-mai:'可可西'
application-label-mi:'可可西'
application-label-mk:'可可西'
application-label-ml:'可可西'
application-label-mn:'可可西'
application-label-mr:'可可西'
application-label-ms:'可可西'
application-label-my:'可可西'
application-label-my-MM:'可可西'
application-label-my-Qaag:'可可西'
application-label-my-ZG:'可可西'
application-label-nb:'可可西'
application-label-ne:'可可西'
application-label-nl:'可可西'
application-label-or:'可可西'
application-label-pa:'可可西'
application-label-pl:'可可西'
application-label-pt:'可可西'
application-label-pt-BR:'可可西'
application-label-pt-PT:'可可西'
application-label-ro:'可可西'
application-label-ru:'可可西'
application-label-si:'可可西'
application-label-sk:'可可西'
application-label-sl:'可可西'
application-label-sq:'可可西'
application-label-sr:'可可西'
application-label-sr-Latn:'可可西'
application-label-sv:'可可西'
application-label-sw:'可可西'
application-label-ta:'可可西'
application-label-te:'可可西'
application-label-th:'可可西'
application-label-tl:'可可西'
application-label-tr:'可可西'
application-label-ug:'可可西'
application-label-uk:'可可西'
application-label-ur:'可可西'
application-label-uz:'可可西'
application-label-vi:'可可西'
application-label-zh:'可可西'
application-label-zh-CN:'可可西'
application-label-zh-HK:'可可西'
application-label-zh-TW:'可可西'
application-label-zu:'可可西'
application-label-zz-ZX:'可可西'
application-icon-120:'res/drawable-ldpi-v4/icon.png'
application-icon-160:'res/drawable-mdpi-v4/icon.png'
application-icon-213:'res/drawable-hdpi-v4/icon.png'
application-icon-240:'res/drawable-hdpi-v4/icon.png'
application-icon-320:'res/drawable-xhdpi-v4/icon.png'
application-icon-480:'res/drawable-xhdpi-v4/icon.png'
application-icon-640:'res/drawable-xhdpi-v4/icon.png'
application-icon-65535:'res/drawable-xhdpi-v4/icon.png'
application: label='可可西' icon='res/drawable-mdpi-v4/icon.png'
application-debuggable
launchable-activity: name='com.tencent.gcloud.msdk.core.policy.MSDKPolicyActivity'  label='' icon=''
leanback-launchable-activity: name='com.tencent.gcloud.msdk.core.policy.MSDKPolicyActivity'  label='' icon='' banner=''
uses-library-not-required:'org.apache.http.legacy'
feature-group: label=''
  uses-gl-es: '0x30001'
  uses-feature: name='android.hardware.bluetooth'
  uses-implied-feature: name='android.hardware.bluetooth' reason='requested android.permission.BLUETOOTH permission, requested android.permission.BLUETOOTH_ADMIN permission, and targetSdkVersion > 4'
  uses-feature: name='android.hardware.faketouch'
  uses-implied-feature: name='android.hardware.faketouch' reason='default feature for all apps'
  uses-feature: name='android.hardware.location'
  uses-implied-feature: name='android.hardware.location' reason='requested android.permission.ACCESS_FINE_LOCATION permission'
  uses-feature: name='android.hardware.microphone'
  uses-implied-feature: name='android.hardware.microphone' reason='requested android.permission.RECORD_AUDIO permission'
  uses-feature: name='android.hardware.screen.landscape'
  uses-implied-feature: name='android.hardware.screen.landscape' reason='one or more activities have specified a landscape orientation'
  uses-feature: name='android.hardware.screen.portrait'
  uses-implied-feature: name='android.hardware.screen.portrait' reason='one or more activities have specified a portrait orientation'
  uses-feature: name='android.hardware.wifi'
  uses-implied-feature: name='android.hardware.wifi' reason='requested android.permission.ACCESS_WIFI_STATE permission, requested android.permission.CHANGE_WIFI_MULTICAST_STATE permission, and requested android.permission.CHANGE_WIFI_STATE permission'
main
other-activities
other-receivers
other-services
supports-screens: 'small' 'normal' 'large' 'xlarge'
supports-any-density: 'true'
locales: '--_--' 'af' 'am' 'ar' 'as' 'az' 'be' 'bg' 'bn' 'bo-CN' 'bs' 'ca' 'cs' 'da' 'de' 'el' 'en' 'en-AU' 'en-CA' 'en-GB' 'en-IN' 'en-US' 'en-XC' 'es' 'es-US' 'et' 'eu' 'fa' 'fi' 'fr' 'fr-CA' 'gl' 'gu' 'hi' 'hr' 'hu' 'hy' 'in' 'is' 'it' 'iw' 'ja' 'jv-Latn' 'ka' 'kk' 'km' 'kn' 'ko' 'ky' 'lo' 'lt' 'lv' 'mai' 'mi' 'mk' 'ml' 'mn' 'mr' 'ms' 'my' 'my-MM' 'my-Qaag' 'my-ZG' 'nb' 'ne' 'nl' 'or' 'pa' 'pl' 'pt' 'pt-BR' 'pt-PT' 'ro' 'ru' 'si' 'sk' 'sl' 'sq' 'sr' 'sr-Latn' 'sv' 'sw' 'ta' 'te' 'th' 'tl' 'tr' 'ug' 'uk' 'ur' 'uz' 'vi' 'zh' 'zh-CN' 'zh-HK' 'zh-TW' 'zu' 'zz-ZX'
densities: '120' '160' '213' '240' '320' '480' '640' '65535'
native-code: 'arm64-v8a'
```



 

## **参考**

[深度探究apk安装过程-多图](https://www.imooc.com/article/16876)

[一文看懂 Android APK 安装的原理](https://zhuanlan.zhihu.com/p/79973102)

[Davilk and ART 01 解释 ](https://juejin.im/post/6844904161507540999)

[Android 存储路径浅析 ](https://www.jianshu.com/p/80e10b3dbba5)

[Android 存储路径你了解多少](https://juejin.im/entry/6844903470261075976)

[Android基础 你必须了解的应用文件目录 ](https://juejin.im/post/6844903537902616590)

[Android SIM卡联系人的增删改查操作 ](https://www.jianshu.com/p/14976b6ef7cf)

[Android系统目录结构](https://www.cnblogs.com/pixy/p/4744501.html) 

[关闭 MIUI 烦人的 USB 安装提示 ](https://www.jianshu.com/p/fc845847af60)

[Android ART dex2oat 浅析 ](https://blog.csdn.net/feelabclihu/article/details/105502166)

 

分类: [计算机理论](https://www.cnblogs.com/kekec/category/244882.html)

标签: [android](https://www.cnblogs.com/kekec/tag/android/)