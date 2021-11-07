# Android Studio

## install

### download
[https://developer.android.google.cn/studio/](https://developer.android.google.cn/studio/)


### package
```
Preparing "Install Android SDK Platform-Tools (revision: 31.0.3)".
Downloading https://dl.google.com/android/repository/platform-tools_r31.0.3-linux.zip
"Install Android SDK Platform-Tools (revision: 31.0.3)" ready.
Installing Android SDK Platform-Tools in /home/foo/Android/Sdk/platform-tools
"Install Android SDK Platform-Tools (revision: 31.0.3)" complete.
"Install Android SDK Platform-Tools (revision: 31.0.3)" finished.
Preparing "Install Android Emulator (revision: 30.9.5)".
Downloading https://dl.google.com/android/repository/emulator-linux_x64-7820599.zip
"Install Android Emulator (revision: 30.9.5)" ready.
Installing Android Emulator in /home/foo/Android/Sdk/emulator
"Install Android Emulator (revision: 30.9.5)" complete.
"Install Android Emulator (revision: 30.9.5)" finished.
Preparing "Install SDK Patch Applier v4 (revision: 1)".
Downloading https://dl.google.com/android/repository/3534162-studio.sdk-patcher.zip
"Install SDK Patch Applier v4 (revision: 1)" ready.
Installing SDK Patch Applier v4 in /home/foo/Android/Sdk/patcher/v4
"Install SDK Patch Applier v4 (revision: 1)" complete.
"Install SDK Patch Applier v4 (revision: 1)" finished.
Preparing "Install Android SDK Tools (revision: 26.1.1)".
Downloading https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
"Install Android SDK Tools (revision: 26.1.1)" ready.
Installing Android SDK Tools in /home/foo/Android/Sdk/tools
"Install Android SDK Tools (revision: 26.1.1)" complete.
"Install Android SDK Tools (revision: 26.1.1)" finished.
Preparing "Install Sources for Android 31 (revision: 1)".
Downloading https://dl.google.com/android/repository/sources-31_r01.zip
java.net.SocketTimeoutException: Read timed out
Warning: An error occurred while preparing SDK package Sources for Android 31: Read timed out.
"Install Sources for Android 31 (revision: 1)" failed.
Preparing "Install Android SDK Build-Tools 31 (revision: 31.0.0)".
Downloading https://dl.google.com/android/repository/build-tools_r31-linux.zip
"Install Android SDK Build-Tools 31 (revision: 31.0.0)" ready.
Installing Android SDK Build-Tools 31 in /home/foo/Android/Sdk/build-tools/31.0.0
"Install Android SDK Build-Tools 31 (revision: 31.0.0)" complete.
"Install Android SDK Build-Tools 31 (revision: 31.0.0)" finished.
Preparing "Install Android SDK Platform 31 (revision: 1)".
Downloading https://dl.google.com/android/repository/platform-31_r01.zip
"Install Android SDK Platform 31 (revision: 1)" ready.
Installing Android SDK Platform 31 in /home/foo/Android/Sdk/platforms/android-31
"Install Android SDK Platform 31 (revision: 1)" complete.
"Install Android SDK Platform 31 (revision: 1)" finished.
Parsing /home/foo/Android/Sdk/build-tools/31.0.0/package.xml
Parsing /home/foo/Android/Sdk/emulator/package.xml
Parsing /home/foo/Android/Sdk/patcher/v4/package.xml
Parsing /home/foo/Android/Sdk/platform-tools/package.xml
Parsing /home/foo/Android/Sdk/platforms/android-31/package.xml
Parsing /home/foo/Android/Sdk/tools/package.xml
java.net.SocketTimeoutException: Read timed out
Warning: An error occurred while preparing SDK package Sources for Android 31: Read timed out.

Preparing "Install Sources for Android 31 (revision: 1)".
Downloading https://dl.google.com/android/repository/sources-31_r01.zip
"Install Sources for Android 31 (revision: 1)" ready.
Installing Sources for Android 31 in /home/foo/Android/Sdk/sources/android-31
"Install Sources for Android 31 (revision: 1)" complete.
"Install Sources for Android 31 (revision: 1)" finished.
Parsing /home/foo/Android/Sdk/build-tools/31.0.0/package.xml
Parsing /home/foo/Android/Sdk/emulator/package.xml
Parsing /home/foo/Android/Sdk/patcher/v4/package.xml
Parsing /home/foo/Android/Sdk/platform-tools/package.xml
Parsing /home/foo/Android/Sdk/platforms/android-31/package.xml
Parsing /home/foo/Android/Sdk/sources/android-31/package.xml
Parsing /home/foo/Android/Sdk/tools/package.xml
Android SDK is up to date.


```
## misc

### SocketTimeoutException
java.net.SocketTimeoutException: Read timed out


配置网络代理即可。

### sdkmanager
```
Failed to install the following Android SDK packages as some licences have not been accepted.
   build-tools;30.0.2 Android SDK Build-Tools 30.0.2
To build this project, accept the SDK license agreements and install the missing components using the Android Studio SDK Manager.
Alternatively, to transfer the license agreements from one workstation to another, see http://d.android.com/r/studio-ui/export-licenses.html

Using Android SDK: /home/foo/Android/Sdk

```


`yes | ~/Android/Sdk/tools/bin/sdkmanager --licenses`

[https://stackoverflow.com/questions/54273412/failed-to-install-the-following-android-sdk-packages-as-some-licences-have-not](https://stackoverflow.com/questions/54273412/failed-to-install-the-following-android-sdk-packages-as-some-licences-have-not)


### jdk version


 报错Exception in thread "main" java.lang.NoClassDefFoundError: javax/xml/bind/...

首先我的jdk是11.05的

这个是由于： 这个是 由于缺少了javax.xml.bind,在jdk10.0.1中没有包含这个包，所以我自己去网上下载了jdk 8，然后把jdk10.0.1换成jdk 8问题就解决了

网址：jdk下载网址：https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html

切换城jdk8。



