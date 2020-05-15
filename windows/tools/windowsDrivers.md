# Windows Drivers



## install

sys和inf是驱动程序内核程序，cat是数字证书

先将sys文件复制到windows/system32/drivers/文件中

手动加载.sys .inf .cat驱动程序



1. 解压下载的文件。
2. 复制文件“amdfix.sys”到系统目录下。
3. 系统目录一般为：C:\WINNT\System32, 64位系统为C:\Windows\SysWOW64
4. 最后点击开始菜单-->运行-->输入regsvr32 amdfix.sys后，回车即可解决错误提示！



网上下载了一个驱动，里面包含文件只有cat/inf/dll文件，怎么安装？

1. 计算机-右键-管理-设备管理器，找到要装驱动的设备上
2. 右键-更新驱动程序-浏览到本地的这个驱动文件夹
3. 开始安装



INF 驱动文件实现命令方式进行安装。。。

测试平台：WIN10 
INF文件本来是驱动安装。。。文件右键单击“安装”即可。。。如果非得使用命令来显示一键安装，就得使用下面的命令。。。

命令如下：
pnputil -i -a *.inf
提示：CMD使用管理员模式



## log

C:\Windows\INF\setupapi.dev.log

``` ini


>>>  [Device Install (DiInstallDriver) - I:\1文件存在这里面\win_rknn_env\usb_driver\WinUSB_Generic_Device.inf]
>>>  Section start 2020/05/14 14:40:09.064
      cmd: "C:\WINDOWS\System32\InfDefaultInstall.exe" "I:\1文件存在这里面\win_rknn_env\usb_driver\WinUSB_Generic_Device.inf"
     ndv: Flags: 0x00000000
     ndv: INF path: I:\1文件存在这里面\win_rknn_env\usb_driver\WinUSB_Generic_Device.inf
     inf: {SetupCopyOEMInf: I:\1文件存在这里面\win_rknn_env\usb_driver\WinUSB_Generic_Device.inf} 14:40:09.067
     inf:      Copy style: 0x00000000
     sto:      {Setup Import Driver Package: I:\1文件存在这里面\win_rknn_env\usb_driver\WinUSB_Generic_Device.inf} 14:40:09.088
     inf:           Provider: libwdi
     inf:           Class GUID: {88bae032-5a81-49f0-bc3d-a4ff138216d6}
     inf:           Driver Version: 02/10/2017,6.1.7600.16385
     inf:           Catalog File: WinUSB_Generic_Device.cat
     sto:           {Copy Driver Package: I:\1文件存在这里面\win_rknn_env\usb_driver\WinUSB_Generic_Device.inf} 14:40:09.095
     sto:                Driver Package = I:\1文件存在这里面\win_rknn_env\usb_driver\WinUSB_Generic_Device.inf
     sto:                Flags          = 0x00000007
     sto:                Destination    = C:\Users\admin\AppData\Local\Temp\{e6fc9251-0627-1945-8b37-2557ddc1fd21}
     sto:                Copying driver package files to 'C:\Users\admin\AppData\Local\Temp\{e6fc9251-0627-1945-8b37-2557ddc1fd21}'.
     flq:                Copying 'I:\1文件存在这里面\win_rknn_env\usb_driver\WinUSB_Generic_Device.cat' to 'C:\Users\admin\AppData\Local\Temp\{e6fc9251-0627-1945-8b37-2557ddc1fd21}\WinUSB_Generic_Device.cat'.
     flq:                Copying 'I:\1文件存在这里面\win_rknn_env\usb_driver\WinUSB_Generic_Device.inf' to 'C:\Users\admin\AppData\Local\Temp\{e6fc9251-0627-1945-8b37-2557ddc1fd21}\WinUSB_Generic_Device.inf'.
     flq:                Copying 'I:\1文件存在这里面\win_rknn_env\usb_driver\amd64\WdfCoInstaller01011.dll' to 'C:\Users\admin\AppData\Local\Temp\{e6fc9251-0627-1945-8b37-2557ddc1fd21}\amd64\WdfCoInstaller01011.dll'.
     flq:                Copying 'I:\1文件存在这里面\win_rknn_env\usb_driver\amd64\WinUSBCoInstaller2.dll' to 'C:\Users\admin\AppData\Local\Temp\{e6fc9251-0627-1945-8b37-2557ddc1fd21}\amd64\WinUSBCoInstaller2.dll'.
     sto:           {Copy Driver Package: exit(0x00000000)} 14:40:09.188
     pol:           {Driver package policy check} 14:40:09.266
     pol:           {Driver package policy check - exit(0x00000000)} 14:40:09.266
     sto:           {Stage Driver Package: C:\Users\admin\AppData\Local\Temp\{e6fc9251-0627-1945-8b37-2557ddc1fd21}\WinUSB_Generic_Device.inf} 14:40:09.267
     inf:                {Query Configurability: C:\Users\admin\AppData\Local\Temp\{e6fc9251-0627-1945-8b37-2557ddc1fd21}\WinUSB_Generic_Device.inf} 14:40:09.272
     inf:                     Driver package uses WDF.
     inf:                     Driver package 'WinUSB_Generic_Device.inf' is configurable.
     inf:                {Query Configurability: exit(0x00000000)} 14:40:09.275
     flq:                Copying 'C:\Users\admin\AppData\Local\Temp\{e6fc9251-0627-1945-8b37-2557ddc1fd21}\WinUSB_Generic_Device.cat' to 'C:\WINDOWS\System32\DriverStore\Temp\{64430fea-508c-f041-b589-7c25fd058e59}\WinUSB_Generic_Device.cat'.
     flq:                Copying 'C:\Users\admin\AppData\Local\Temp\{e6fc9251-0627-1945-8b37-2557ddc1fd21}\WinUSB_Generic_Device.inf' to 'C:\WINDOWS\System32\DriverStore\Temp\{64430fea-508c-f041-b589-7c25fd058e59}\WinUSB_Generic_Device.inf'.
     flq:                Copying 'C:\Users\admin\AppData\Local\Temp\{e6fc9251-0627-1945-8b37-2557ddc1fd21}\amd64\WdfCoInstaller01011.dll' to 'C:\WINDOWS\System32\DriverStore\Temp\{64430fea-508c-f041-b589-7c25fd058e59}\amd64\WdfCoInstaller01011.dll'.
     flq:                Copying 'C:\Users\admin\AppData\Local\Temp\{e6fc9251-0627-1945-8b37-2557ddc1fd21}\amd64\WinUSBCoInstaller2.dll' to 'C:\WINDOWS\System32\DriverStore\Temp\{64430fea-508c-f041-b589-7c25fd058e59}\amd64\WinUSBCoInstaller2.dll'.
     sto:                {DRIVERSTORE IMPORT VALIDATE} 14:40:09.510
     sig:                     {_VERIFY_FILE_SIGNATURE} 14:40:09.549
     sig:                          Key      = WinUSB_Generic_Device.inf
     sig:                          FilePath = C:\WINDOWS\System32\DriverStore\Temp\{64430fea-508c-f041-b589-7c25fd058e59}\WinUSB_Generic_Device.inf
     sig:                          Catalog  = C:\WINDOWS\System32\DriverStore\Temp\{64430fea-508c-f041-b589-7c25fd058e59}\WinUSB_Generic_Device.cat
!    sig:                          Verifying file against specific (valid) catalog failed.
!    sig:                          Error 0x800b0109: A certificate chain processed, but terminated in a root certificate which is not trusted by the trust provider.
     sig:                     {_VERIFY_FILE_SIGNATURE exit(0x800b0109)} 14:40:09.564
     sig:                     {_VERIFY_FILE_SIGNATURE} 14:40:09.567
     sig:                          Key      = WinUSB_Generic_Device.inf
     sig:                          FilePath = C:\WINDOWS\System32\DriverStore\Temp\{64430fea-508c-f041-b589-7c25fd058e59}\WinUSB_Generic_Device.inf
     sig:                          Catalog  = C:\WINDOWS\System32\DriverStore\Temp\{64430fea-508c-f041-b589-7c25fd058e59}\WinUSB_Generic_Device.cat
!    sig:                          Verifying file against specific Authenticode(tm) catalog failed.
!    sig:                          Error 0x800b0109: A certificate chain processed, but terminated in a root certificate which is not trusted by the trust provider.
     sig:                     {_VERIFY_FILE_SIGNATURE exit(0x800b0109)} 14:40:09.576
!!!  sig:                     Driver package catalog file certificate does not belong to Trusted Root Certificates, and Code Integrity is enforced.
!!!  sig:                     Driver package failed signature validation. Error = 0xE0000247
     sto:                {DRIVERSTORE IMPORT VALIDATE: exit(0xe0000247)} 14:40:09.580
!!!  sig:                Driver package failed signature verification. Error = 0xE0000247
!!!  sto:                Failed to import driver package into Driver Store. Error = 0xE0000247
     sto:           {Stage Driver Package: exit(0xe0000247)} 14:40:09.586
     sto:      {Setup Import Driver Package - exit (0xe0000247)} 14:40:09.592
!!!  inf:      Failed to import driver package into driver store
!!!  inf:      Error 0xe0000247: A problem was encountered while attempting to add the driver to the store.
     inf: {SetupCopyOEMInf exit (0xe0000247)} 14:40:11.562
<<<  Section end 2020/05/14 14:40:11.562
<<<  [Exit status: FAILURE(0xe0000247)]
```





![1589441733455](C:\Users\admin\Pictures\1589441733455.png)







![1589441788220](C:\Users\admin\Pictures\1589441788220.png)



winddk 7600下devcon add_dp







win2003安装证书服务后，没法启动证书服务,提示:“已处理证书链,但是在不受信任提供程序信任的根证书中终止。0x800b0109(-2146762487)”，

打开程序-管理工具-证书颁发机构，此时证书服务是没有启动的，在证书服务上点右键，选择所有任务-续订CA证书，然后启动CA服务，成功！！！





## Error: A certificate chain processed, but terminated in a root certificate which is not trusted by the trust provider. 0x800b0109 <-2146762487>

#### Problem

When installing an SSL certificate using Microsoft power shell, you may receive the following error message:

A certificate chain processed, but terminated in a root certificate which is not trusted by the trust provider. 0x800b0109 <-2146762487>



#### Cause

This error occurs when the root and/or intermediate certificate are not installed on the server.

#### Solution

**Step 1:**  Download the new Standard root certificate

To download the new Standard root certificate, click the attachment below

**Step 2:**  Import the Intermediate CA Certificate for Microsoft IIS customers

1. Open Microsoft Management Console (MMC), click **Start** > **Run** > enter **MMC** > **OK**
2. From the console, select **File** or **Console** > **Add/Remove Snap-In**
3. From the list, select **Certificates** > **Add** > **Computer Account** > **Local Computer** > **OK**
4. From left menu, expand Server Name > **Certificates(Local Computer)** > **Trusted Root** **Certification Authorities** > **Certificates**
5. Right-click **Certificates** folder > select **All Tasks** > **Import**
6. This will open the Certificate Import Wizard > click **Next**
7. Browse to the location of the intermediate certificate > select **Next**
8. Select **Place the certificate in the following store:  Trusted Root Certification Authorities**
9. Click **Finish**
10. Stop and restart the web site