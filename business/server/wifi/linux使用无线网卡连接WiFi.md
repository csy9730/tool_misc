# linux使用无线网卡连接WiFi

本教程是采用命令行来连接WiFi。

### 具体步骤如下

------

1. 检查可用网卡。
   命令为：

   ```
   iw dev
   ```

   在`Interface`后就是可用网卡，我的是`wlan0`。

2. 检查网卡状态。
   命令为：

   ```
   ip link show wlan0
   ```

   如果在<>中没有`UP`的字样，表示网卡没有激活。

3. 激活网卡。
   如果第2步中，网卡显示激活，则不用此步骤。
   激活网卡的命令为：

   ```
    ip link set wlan0 up
   ```

   为了保险起见，建议重复第2步，检查网卡状态。

4. 搜索周围可用WiFi。
   命令为：

   ```
   iw wlan0 scan | grep SSID
   ```

   在SSID后面的就是wifi的名称。

5. 连接wifi。
   这一步分为两种情况，有密码和无密码的WiFi。

   - 对于没有密码的连接较为简单。直接连接即可。
     命令为：

   ```
   iw dev wlan0 connect wifiname
   ```

   `wifiname`为要连接的wifi的名称。

   - 如果网络是有密码，使用的是 WPA 或 WPA2 协议的话，连接就稍微复杂点。

     命令为：

     ```
      wpa_supplicant -B -i wlp9s0 -c<(wpa_passphrase "wifiname" "password")
     ```

     该步骤需要用到

     ```
     wpasupplicant
     ```

     工具，默认是没有的，需要自行安装。

6. 为网卡分配IP地址。
   命令为：

   ```
   dhclient wlan0
   ```

   如果之前为该网卡分配过IP，可能会出现以下错误：

   ```
   dhclient(9306) is already running - exiting.
   This version of ISC DHCP is based on the release available
   on ftp.isc.org. Features have been added and other changes
   have been made to the base software release in order to make
   it work better with this distribution.
   Please report for this software via the CentOS Bugs Database:
   http://bugs.centos.org/
   exiting.
   ```

   只需要把dhclient后面()里的进程杀掉`本例是9306`，然后执行`dhclient wlan0`重新分配IP即可。

7. 检查连接状态。
   此时，重复第2步，检查网卡状态，如果<>中有`LOWER_UP`字样，表示连接成功。

到这一步就说明了网络连接成功了。