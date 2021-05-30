# armbian/debian/linux 硬盘休眠

[湛青](https://www.jianshu.com/u/7a0d2c6fc920)关注

0.0642020.01.10 14:06:32字数 151阅读 2,479

刷了armbian 发现硬盘总是不休眠, 即使没有人在用

> $ sudo /sbin/hdparm -C /dev/sda
> /dev/sda:
> drive state is: active/idle

查看了相关资料后发现,可以修改/etc/hdparm.conf
加上下面的配置 (请修改为自己的目录)



```csharp
/dev/disk/by-id/ata-TOSHIBA_MD04ABA400V_2818KRSKFMYB {
    apm  = 127
    spindown_time = 60
    write_cache = on
}
```

然后执行
`sudo /usr/lib/pm-utils/power.d/95hdparm-apm resume`
或者重启

在5分没使用硬盘的情况下, 硬盘会自动休眠了

ps :

1. /dev/disk/by-id/* 自己去看下这个目录下自己的文件名
2. `spindown_time 60` 计算参考



```csharp
0 = disabled
1..240 = multiples of 5 seconds (5 seconds to 20 minutes)
241..251 = 1..11 x 30 mins
252 = 21 mins
253 = vendor defined (8..12 hours)
254 = reserved
255 = 21 mins + 15 secs
```

1. `write_cache` 写缓存自己决定是否要开启,可以使用off