# 玩转WakeOnLan(远程开机)

[![img](https://cdn2.jianshu.io/assets/default_avatar/3-9a2bcc21a5d89e21dafc73b39dc5f582.jpg)](https://www.jianshu.com/u/45491724ad5d)

[爱捣腾的吴大爷](https://www.jianshu.com/u/45491724ad5d)关注

12017.09.09 15:07:15字数 1,508阅读 50,634

# WakeOnLan

首先简单介绍一下什么是WakeOnLan
Wake-On-LAN简称WOL，是一种电源管理功能；它是由IBM公司提出的网络唤醒标准，目前该标准已被大多数主板厂商支持。支持该标准的主板允许从远程通过网络唤醒计算机，也就是远程开机。

介于大多数人只想实现远程开机而不深究原理，因此原理我们放在后面讲。

------

# 如何实现远程开机

简单来说只需要两步

1. 需要远程唤醒的计算机设置好允许远程WOL唤醒
2. 通过软件向远端计算机发送唤醒请求

------

先说第一步

首先你需要确认自己主板的网卡是否支持WOL标准并开启它。现今几乎所有的主板都是支持该标准的，不过WOL功能则有些默认开启，有些默认关闭，需要自行确认。

以Win10为例，打开网络和共享中心（任务栏图标如下）

![img](https://upload-images.jianshu.io/upload_images/1423427-ee0f2aeda3616be9.png?imageMogr2/auto-orient/strip|imageView2/2/w/29/format/webp)

右键打开网络和共享中心

找到你的网络连接，一般它可能叫以太网或本地连接。

![img](https://upload-images.jianshu.io/upload_images/1423427-dc40948091eb481b.png?imageMogr2/auto-orient/strip|imageView2/2/w/418/format/webp)

以太网状态

打开属性->配置

![img](https://upload-images.jianshu.io/upload_images/1423427-86b233c13da6e0dd.png?imageMogr2/auto-orient/strip|imageView2/2/w/420/format/webp)

以太网属性

到这里因为系统和驱动不同，可能导致WOL设置的位置不同，例如我的WOL设置在网卡属性面板的电源管理选项卡中并且默认开启，但有些计算机上则WOL设置可能在高级选项卡的属性中，属性名一般为Wake On Lan或者类似的名称，你可以在属性值中将其设置为启用。

另外个别主板还需要在BIOS中开启WOL支持和设置电源策略才可以支持远程唤醒，具体可以参考主板的说明书进行设置。

![img](https://upload-images.jianshu.io/upload_images/1423427-614766ccc3e5f2e8.png?imageMogr2/auto-orient/strip|imageView2/2/w/464/format/webp)

电源管理

![img](https://upload-images.jianshu.io/upload_images/1423427-14bdf5f366a29d97.png?imageMogr2/auto-orient/strip|imageView2/2/w/462/format/webp)

网卡高级属性

------

第二步
这里我们需要一些WakeOnLan的软件帮助我们发送唤醒请求。
（如果你对远程感兴原理感兴趣，并想自己实现，后面我会讲到）

这里介绍几个WakeOnLan软件并附上下载地址。

![img](https://upload-images.jianshu.io/upload_images/1423427-7c36293e7ada249a.png?imageMogr2/auto-orient/strip|imageView2/2/w/360/format/webp)

Wake on Lan for Windows GUI

这是一款具有图形界面的WakeOnLan软件，操作非常简单，功能较为单一，但可以满足需求。

从上到下的填写内容依次为：
远端计算机的网卡MAC地址
远端计算机的IP地址或域名
远端计算机的子网掩码
发送选项（互联网或者本地子网）
远端计算机端口号

填好后点击Wake Up执行唤醒
[点击下载](https://link.jianshu.com/?t=https://www.depicus.com/downloads/wakeonlangui.zip)

![img](https://upload-images.jianshu.io/upload_images/1423427-894523e63f3563cb.png?imageMogr2/auto-orient/strip|imageView2/2/w/668/format/webp)

Wake On Lan Command Line

这是一款命令行WakeOnLan软件，使用也相对简单，你可以通过cmd命令或者创建批处理文件执行远程唤醒。



```cmd
wolcmd [mac address] [ip address] [subnet mask] [port number]
```

例如：



```cmd
wolcmd 009027a324fe 195.188.159.20 255.255.255.0 8900
```

[点击下载](https://link.jianshu.com/?t=https://www.depicus.com/downloads/wolcmd.zip)

当然手机上也有很多WakeOnLan软件，大家可以自行搜索下载，操作基本都类似。

------

# 测试

我们不能为了测试而去反复开关计算机，那么如何得知远程计算机是否收到了唤醒请求呢？

![img](https://upload-images.jianshu.io/upload_images/1423427-4ca9404b4ced2144.png?imageMogr2/auto-orient/strip|imageView2/2/w/445/format/webp)

Wake on Lan Monitor/Sniffer

我们可以通过Wake on Lan Monitor/Sniffer来检测计算机是否收到了唤醒请求。
它界面非常简洁，我们只需设置好UDP端口号点击Start即可。UDP端口号就是用来接收唤醒请求的那个端口号。

如图当接收到发送给本机4343端口的唤醒请求时，该软件会显示收到请求的具体封包内容。（后面会讲解唤醒（魔术）封包）
[点击下载](https://link.jianshu.com/?t=https://www.depicus.com/downloads/wakeonlanmonitor.zip)

------

如果你只想玩玩WOL远程唤醒那么一般到这里就可以了，以下内容适合有一定计算机基础并且好奇心旺盛的读者。

# WakeOnLan原理

Wake-On-LAN的实现，主要是向目标主机发送特殊格式的数据包，俗称魔术包（Magic Packet）。

MagicPacket格式的数据包是由AMD公司开发推广的技术，虽然其并非世界公认的标准，但是仍然受到很多网卡制造商的支持，因此许多具有网络唤醒功能的网卡都能与之兼容。

# MagicPacket

魔法数据包（Magic Packet）是一个广播性的帧（frame），通过端口7或端口9进行发送，且可以用无连接（Connectionless protocol）的通信协议（如UDP）来传递。
在魔法数据包内，每次都会先有连续6个"FF"（十六进制，换算成二进制即：11111111）的数据，即：FF FF FF FF FF FF，在连续6个"FF"后则开始带出MAC地址信息（MAC地址重复16次），有时还会带出4字节或6字节的密码，一旦经由网卡侦测、解读、研判（广播）魔法数据包的内容，内容中的MAC地址、密码若与电脑自身的地址、密码吻合，就会引导唤醒、开机的程序。

MagicPacket 魔术数据包的格式一般看上去像下面这个样子
假设MAC地址为：00-00-00-00-00

| 序号 |    MagicPacket    |
| :--: | :---------------: |
|  1   | FF FF FF FF FF FF |
|  2   | 00 00 00 00 00 00 |
|  3   | 00 00 00 00 00 00 |
|  4   | 00 00 00 00 00 00 |
|  5   | 00 00 00 00 00 00 |
|  6   | 00 00 00 00 00 00 |
|  7   | 00 00 00 00 00 00 |
|  8   | 00 00 00 00 00 00 |
|  9   | 00 00 00 00 00 00 |
|  10  | 00 00 00 00 00 00 |
|  11  | 00 00 00 00 00 00 |
|  12  | 00 00 00 00 00 00 |
|  13  | 00 00 00 00 00 00 |
|  14  | 00 00 00 00 00 00 |
|  15  | 00 00 00 00 00 00 |
|  16  | 00 00 00 00 00 00 |
|  17  | 00 00 00 00 00 00 |

魔法数据包（Magic Packet）结构上非常简单。

下面我们使用C#语言去实现一个WakeOnLan软件的功能（能够构建并发送魔法数据包唤醒远程计算机）



```c
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using System.Runtime.InteropServices;
using System.Text;
using System.Text.RegularExpressions;

namespace WoL
{
    /// <summary>
    /// 网络唤醒
    /// </summary>
    public class WakeOnLan
    {
        #region WakeOnLan

        /// <summary>
        /// 发送一个WOL魔术包到远程计算机
        /// </summary>
        /// <param name="macAddress">MAC地址</param>
        /// <param name="hostNameOrAddress">Host主机名或IP地址</param>
        /// <param name="subnetMask">子网掩码</param>
        /// <param name="udpPort">WOL UDP 端口</param>
        /// <param name="ttl">WOL生存时间</param>
        /// <remarks></remarks>
        public void WakeUp(string macAddress, string hostNameOrAddress, string subnetMask, int udpPort = 9, short ttl = 128) {
            // 获取主机的IP地址
            var hostIPs = Dns.GetHostAddresses(hostNameOrAddress).Where(a=>a.AddressFamily == AddressFamily.InterNetwork);

            foreach (var hostIP in hostIPs) {
                // 获取该主机的广播地址
                var broadcastAddress = GetBroadcast(hostIP.ToString(), subnetMask);
                
                WakeUp(macAddress, broadcastAddress, udpPort, ttl);
            }
            
        }

        /// <summary>
        /// 发送一个WOL魔术包到远程计算机
        /// </summary>
        /// <param name="macAddress">MAC地址</param>
        /// <param name="broadcastAddress">网络广播地址</param>
        /// <param name="udpPort">WOL UDP 端口</param>
        /// <param name="ttl">WOL生存时间</param>
        /// <remarks></remarks>
        public void WakeUp(string macAddress, string broadcastAddress = null, int udpPort = 9, short ttl = 128)
        {

            if (string.IsNullOrWhiteSpace(macAddress))
            {
                throw new ArgumentNullException("macAddress", "必须提供MAC地址！");
            }

            if (!string.IsNullOrWhiteSpace(broadcastAddress) && !Regex.IsMatch(broadcastAddress, @"(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\.(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\.(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\.(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)"))
            {
                throw new ArgumentNullException("broadcastAddress", "网络广播地址格式错误！");
            }

            // 获取MAC地址对应的字节数组
            var bytesMac = GetMac(macAddress);

            // 广播地址
            var broadcastIP = IPAddress.Broadcast;

            if (!string.IsNullOrWhiteSpace(broadcastAddress))
            {
                broadcastIP = IPAddress.Parse(broadcastAddress);
            }

            WakeUp(bytesMac, broadcastIP, udpPort, ttl);
        }

        /// <summary>
        /// 发送一个WOL魔术包到远程计算机
        /// </summary>
        /// <param name="macAddress">唤醒MAC地址</param>
        /// <param name="broadcastIPAddress">网络广播地址</param>
        /// <param name="udpPort">WOL UDP 端口</param>
        /// <param name="ttl">WOL生存时间</param>
        /// <remarks></remarks>
        public void WakeUp(string macAddress, IPAddress broadcastIPAddress = null, int udpPort = 9, short ttl = 128)
        {

            if (string.IsNullOrWhiteSpace(macAddress))
            {
                throw new ArgumentNullException("macAddress", "必须提供MAC地址！");
            }

            var bytesMac = GetMac(macAddress);

            WakeUp(bytesMac, broadcastIPAddress, udpPort, ttl);
        }

        /// <summary>
        /// 发送一个WOL魔术包到远程计算机
        /// </summary>
        /// <param name="bytesMac">MAC地址字节数组</param>
        /// <param name="broadcastIPAddress">网络广播地址</param>
        /// <param name="udpPort">WOL UDP 端口</param>
        /// <param name="ttl">WOL生存时间</param>
        /// <remarks></remarks>
        public void WakeUp(byte[] bytesMac, IPAddress broadcastIPAddress = null, int udpPort = 9, short ttl = 128) {

            if (!(udpPort > 0 && udpPort < 65535))
            {
                throw new ArgumentNullException("udpPort", "端口范围错误，端口号的范围从0到65535！");
            }

            #region 构造魔术封包
            // 局域网唤醒魔术包包含一个6字节的头和目标的MAC地址6字节，重复16次。
            var wolPacket = new byte[17 * 6];

            var ms = new MemoryStream(wolPacket, true);

            // 写入6字节的0xFF头
            for (int i = 0; i < 6; i++)
            {
                ms.WriteByte(0xFF);
            }

            // 写MAC地址16次
            for (int i = 0; i < 16; i++)
            {
                ms.Write(bytesMac, 0, bytesMac.Length);
            } 
            #endregion

            // 创建UDP客户端
            var udp = new UdpClient();

            // 广播地址
            var broadcast = broadcastIPAddress ?? IPAddress.Broadcast;
            // 设置udp连接的地址和端口
            udp.Connect(broadcast, udpPort);
            // 设置TTL
            udp.Ttl = ttl;
            // 发送魔法数据包
            udp.Send(wolPacket, wolPacket.Length);
        }

        /// <summary>
        /// 处理字符串的MAC地址
        /// </summary>
        /// <param name="mac">以空格，：，-，分隔的mac地址</param>
        /// <returns>mac地址的字节数组</returns>
        public byte[] GetMac(string mac)
        {
            // 地址格式判断并不严谨，以空格，：，-，分隔的mac地址，也可以是混用分隔符的地址。
            if (!Regex.IsMatch(mac, @"^([0-9a-fA-F]{2})(([\s:-][0-9a-fA-F]{2}){5})$"))
            {
                throw new ArgumentNullException("mac", "MAC地址格式错误！");
            }

            // 去除分隔符
            var mMac = mac.Replace(" ", "")
                .Replace(":", "")
                .Replace("-", "");

            byte[] bytesMac = new byte[6];

            for (int i = 0; i < 6; i++)
            {
                //bytesMac[i] = (byte)Int32.Parse(mMac.Substring((i * 2), 2), NumberStyles.HexNumber);
                // 将字符串转化为字节
                bytesMac[i] = Convert.ToByte(mMac.Substring((i * 2), 2), 16);
            }

            return bytesMac;
        }
        #endregion

        #region 计算地址

        /// <summary> 
        /// 获得广播地址 
        /// </summary> 
        /// <param name="ipAddress">IP地址</param> 
        /// <param name="subnetMask">子网掩码</param> 
        /// <returns>广播地址</returns> 
        public static IPAddress GetBroadcast(string ipAddress, string subnetMask)
        {
            return GetBroadcast(IPAddress.Parse(ipAddress), IPAddress.Parse(subnetMask));
        }

        /// <summary> 
        /// 获得广播地址 
        /// </summary> 
        /// <param name="ipAddress">IP地址</param> 
        /// <param name="subnetMask">子网掩码</param> 
        /// <returns>广播地址</returns> 
        public static IPAddress GetBroadcast(IPAddress ipAddress, IPAddress subnetMask)
        {

            byte[] ip = ipAddress.GetAddressBytes();
            byte[] sub = subnetMask.GetAddressBytes();

            // 广播地址=子网按位求反 再 或IP地址 
            for (int i = 0; i < ip.Length; i++)
            {
                ip[i] = (byte)((~sub[i]) | ip[i]);
            }

            return new IPAddress(ip);
        }

        #endregion

        #region Ping
        /// <summary>
        /// 默认超时时间
        /// </summary>
        private const int PING_TIMEOUT = 1000;

        /// <summary>
        /// 检测目标主机是否处于可访问的状态
        /// </summary>
        /// <param name="hostNameOrAddress">主机名称或IP地址</param>
        /// <returns></returns>
        public static bool IsComputerAccessible(string hostNameOrAddress)
        {
            return IsComputerAccessible(hostNameOrAddress, PING_TIMEOUT);
        }

        /// <summary>
        /// 检测目标主机是否处于可访问的状态
        /// </summary>
        /// <param name="hostNameOrAddress">主机名称或IP地址</param>
        /// <param name="timeout">超时时间</param>
        /// <returns></returns>
        public static bool IsComputerAccessible(string hostNameOrAddress, int timeout)
        {
            var pingSender = new Ping();
            var reply = pingSender.Send(hostNameOrAddress, timeout);
            // 这里只判断ping成功的情况，如果需要更详细的状态可以自行处理
            return reply.Status == IPStatus.Success;
        }
        #endregion

        #region Arp

        /// <summary>
        /// 本地方法
        /// </summary>
        internal static class NativeMethods
        {
            /// <summary>
            /// 发送arp封包
            /// </summary>
            /// <param name="DestIP">目标地址</param>
            /// <param name="SrcIP">发送者IP，可以为0</param>
            /// <param name="pMacAddr">返回的远端IP的Mac地址</param>
            /// <param name="PhyAddrLen">返回MAC地址长度</param>
            /// <returns></returns>
            [DllImport("iphlpapi.dll", ExactSpelling = true)]
            internal static extern int SendARP(int DestIP, int SrcIP, byte[] pMacAddr, ref uint PhyAddrLen);
        }

        /// <summary>
        /// 获取MAC地址
        /// </summary>
        /// <param name="ipAddress">IP地址</param>
        /// <returns></returns>
        public static string GetMACAddress(IPAddress ipAddress)
        {
            var addressBytes = ipAddress.GetAddressBytes();
            var address = BitConverter.ToInt32(addressBytes, 0);

            var macAddr = new byte[6];
            var macAddrLen = (uint)macAddr.Length;

            if (NativeMethods.SendARP(address, 0, macAddr, ref macAddrLen) != 0)
            {
                return null;
            }

            var macAddressString = new StringBuilder();

            for (int i = 0; i < macAddr.Length; i++)
            {
                if (macAddressString.Length > 0)
                {
                    macAddressString.Append(":");
                }
                macAddressString.AppendFormat("{0:x2}", macAddr[i]);
            }

            return macAddressString.ToString();
        }

        /// <summary>
        /// 获取MAC地址
        /// </summary>
        /// <param name="hostName">主机名称</param>
        /// <returns></returns>
        public static string GetMACAddress(string hostName)
        {

            IPAddress[] mIPAddress = null;
            try
            {
                mIPAddress = Dns.GetHostAddresses(hostName);
            }
            catch
            {

                return null;
            }

            if (mIPAddress.Length == 0)
            {
                return null;
            }

            // 为该主机找到第一个地址的IPV4地址
            #region .Net 2 方法
            /*
                IPAddress ipAddress = null;

                foreach (IPAddress ip in hostEntry.AddressList)
                {
                    if (ip.AddressFamily == System.Net.Sockets.AddressFamily.InterNetwork)
                    {
                        ipAddress = ip;
                        break;
                    }
                }
                */
            #endregion

            // 如果在.net 3.5上运行，你可以用LINQ来做
            var ipAddress = mIPAddress.First(ip => ip.AddressFamily == AddressFamily.InterNetwork);

            return GetMACAddress(ipAddress);

        }

        /// <summary>
        /// 获取MAC地址列表
        /// </summary>
        /// <param name="hostName">主机名称</param>
        /// <returns></returns>
        public static IList<string> GetMACAddressArrray(string hostName)
        {

            IPHostEntry mIPHostEntry = null;
            try
            {
                mIPHostEntry = Dns.GetHostEntry(hostName);
            }
            catch
            {
                return null;
            }

            if (mIPHostEntry.AddressList.Length == 0)
            {
                return null;
            }

            var ipAddressList = mIPHostEntry.AddressList.Where(ip => ip.AddressFamily == AddressFamily.InterNetwork);

            var macList = new List<string>();

            foreach (var ipAddress in ipAddressList)
            {
                macList.Add(GetMACAddress(ipAddress));
            }

            return macList;

        }

        #endregion
    }
}
```



```c
static void Main(string[] args)
{
    var wol = new WakeOnLan();
    // 发送魔术数据包，唤醒远程计算机
    wol.WakeUp("A9-F8-02-FE-94-D0", "192.168.1.100", "255.255.255.0", 40000);

    // 判断远程计算机是否开启（由于防火墙等原因不一定有效，同时由于开机需要时间，通常等待数秒到一两分钟不等才能检测到远程计算机的状态）
    var computerAccessible = WakeOnLan.IsComputerAccessible("192.168.1.100");
    
    // 通过ARP协议尝试获取远程计算机的mac地址（通常局域网内有效）
    var mac = WakeOnLan.GetMACAddress("192.168.1.100");
    
    Console.WriteLine($"远程计算机的mac地址：{mac}");

    Console.ReadKey();
}
```

其它语言实现也大多类似，关键是构筑一个魔术数据包并把它发送给需要唤醒的目标计算机。

WakeOnLan的介绍上魔术数据包是可以包含密码的，但我并未找到类似的实现，尚不清楚是否能够唤醒有bios启动密码或硬盘密码的计算机。如果有读者知道还请留言告知，在此先行谢过。

------

以上内容是我无聊时鼓捣总结的产物，如有错误之处欢迎各位指出。