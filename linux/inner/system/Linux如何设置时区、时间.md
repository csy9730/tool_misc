# Linux如何设置时区、时间

## 时间

### date

```
root@123:~/work/test$ date
2018年 03月 02日 星期五 14:09:45 CST
```



### 和日期相关的文件

时区的设置文件：/etc/timezone
时间相关文件： /etc/localtime
时间相关的文件： /usr/share/zoneinfo/Asia这里边放着亚洲主要城市的时间

### tzselect

选择时区的命令：



    [root@123]: /etc$ tzselect
    Please identify a location so that time zone rules can be set correctly.
    Please select a continent, ocean, "coord", or "TZ".
     1) Africa
     2) Americas
     3) Antarctica
     4) Asia
     5) Atlantic Ocean
     6) Australia
     7) Europe
     8) Indian Ocean
     9) Pacific Ocean
    10) coord - I want to use geographical coordinates.
    11) TZ - I want to specify the time zone using the Posix TZ format.
    #? 4
    Please select a country whose clocks agree with yours.
     1) Afghanistan       18) Israel            35) Palestine
     2) Armenia       19) Japan         36) Philippines
     3) Azerbaijan        20) Jordan            37) Qatar
     4) Bahrain       21) Kazakhstan        38) Russia
     5) Bangladesh        22) Korea (North)     39) Saudi Arabia
     6) Bhutan        23) Korea (South)     40) Singapore
     7) Brunei        24) Kuwait            41) Sri Lanka
     8) Cambodia          25) Kyrgyzstan        42) Syria
     9) China         26) Laos          43) Taiwan
    10) Cyprus        27) Lebanon           44) Tajikistan
    11) East Timor        28) Macau         45) Thailand
    12) Georgia       29) Malaysia          46) Turkmenistan
    13) Hong Kong         30) Mongolia          47) United Arab Emirates
    14) India         31) Myanmar (Burma)       48) Uzbekistan
    15) Indonesia         32) Nepal         49) Vietnam
    16) Iran          33) Oman          50) Yemen
    17) Iraq          34) Pakistan
    #? 9
    Please select one of the following time zone regions.
    1) Beijing Time
    2) Xinjiang Time
    #? 1
    
    The following information has been given:
    China
    Beijing Time
    Therefore TZ='Asia/Shanghai' will be used.



设置timezone的时区

```
sudo timedatectl set-timezone 'Asia/Shanghai'
```


或者

```
echo "Asia/Shanghai" > /etc/timezone
```



设置时间

```
rm -rf /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
```

