# ethtool

命令描述：
ethtool 是用于查询及设置网卡参数的命令。

## install
`apt install ethtool`


## 使用概要



使用概要：
```
ethtool ethx       //查询ethx网口基本设置，其中 x 是对应网卡的编号，如eth0、eth1等等
ethtool –h        //显示ethtool的命令帮助(help)
ethtool –i ethX    //查询ethX网口的相关信息 
ethtool –d ethX    //查询ethX网口注册性信息
ethtool –r ethX    //重置ethX网口到自适应模式
ethtool –S ethX    //查询ethX网口收发包统计
ethtool –s ethX [speed 10|100|1000] [duplex half|full]  [autoneg on|off]        //设置网口速率10/100/1000M、设置网口半/全双工、设置网口是否自协商

ethtool -E eth0 magic 0x10798086 offset 0x10 value 0x1A  修改网卡EEPROM内容（0x1079 网卡device id , 0x8086网卡verdor id  ）

ethtool -e eth0  : dump网卡EEPROM内容
```

普通的百兆网卡理论传输速度为100Mbps，实际换算后极限下载速度12.5MB/s，而千兆网卡的理论传输速度则为125MB/s。
```
ethtool –s eth0 1000 full on
ethtool eth0 –s  speed 1000 duplex full autoneg on 

ethtool -s eth1 autoneg off speed 100 duplex full
ethtool -s eth0 speed 1000 duplex full autoneg on
```
### 查询网卡
```

(base) ➜  ~ ethtool eno1
Settings for eno1:
        Supported ports: [ TP ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Supported pause frame use: No
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Advertised pause frame use: No
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Speed: Unknown!
        Duplex: Unknown! (255)
        Port: Twisted Pair
        PHYAD: 2
        Transceiver: internal
        Auto-negotiation: on
        MDI-X: Unknown (auto)
Cannot get wake-on-lan settings: Operation not permitted
        Current message level: 0x00000007 (7)
                               drv probe link
        Link detected: no
```


## help
```
admin@DS918Plus:~$ ethtool -h
ethtool version 3.13
Usage:
        ethtool DEVNAME Display standard information about device
        ethtool -s|--change DEVNAME     Change generic options
                [ speed %d ]
                [ duplex half|full ]
                [ port tp|aui|bnc|mii|fibre ]
                [ mdix auto|on|off ]
                [ autoneg on|off ]
                [ advertise %x ]
                [ phyad %d ]
                [ xcvr internal|external ]
                [ wol p|u|m|b|a|g|s|d... ]
                [ sopass %x:%x:%x:%x:%x:%x ]
                [ msglvl %d | msglvl type on|off ... ]
        ethtool -a|--show-pause DEVNAME Show pause options
        ethtool -A|--pause DEVNAME      Set pause options
                [ autoneg on|off ]
                [ rx on|off ]
                [ tx on|off ]
        ethtool -c|--show-coalesce DEVNAME      Show coalesce options
        ethtool -C|--coalesce DEVNAME   Set coalesce options
                [adaptive-rx on|off]
                [adaptive-tx on|off]
                [rx-usecs N]
                [rx-frames N]
                [rx-usecs-irq N]
                [rx-frames-irq N]
                [tx-usecs N]
                [tx-frames N]
                [tx-usecs-irq N]
                [tx-frames-irq N]
                [stats-block-usecs N]
                [pkt-rate-low N]
                [rx-usecs-low N]
                [rx-frames-low N]
                [tx-usecs-low N]
                [tx-frames-low N]
                [pkt-rate-high N]
                [rx-usecs-high N]
                [rx-frames-high N]
                [tx-usecs-high N]
                [tx-frames-high N]
                [sample-interval N]
        ethtool -g|--show-ring DEVNAME  Query RX/TX ring parameters
        ethtool -G|--set-ring DEVNAME   Set RX/TX ring parameters
                [ rx N ]
                [ rx-mini N ]
                [ rx-jumbo N ]
                [ tx N ]
        ethtool -k|--show-features|--show-offload DEVNAME       Get state of protocol offload and other features
        ethtool -K|--features|--offload DEVNAME Set protocol offload and other features
                FEATURE on|off ...
        ethtool -i|--driver DEVNAME     Show driver information
        ethtool -d|--register-dump DEVNAME      Do a register dump
                [ raw on|off ]
                [ file FILENAME ]
        ethtool -e|--eeprom-dump DEVNAME        Do a EEPROM dump
                [ raw on|off ]
                [ offset N ]
                [ length N ]
        ethtool -E|--change-eeprom DEVNAME      Change bytes in device EEPROM
                [ magic N ]
                [ offset N ]
                [ length N ]
                [ value N ]
        ethtool -r|--negotiate DEVNAME  Restart N-WAY negotiation
        ethtool -p|--identify DEVNAME   Show visible port identification (e.g. blinking)
               [ TIME-IN-SECONDS ]
        ethtool -t|--test DEVNAME       Execute adapter self test
               [ online | offline | external_lb ]
        ethtool -S|--statistics DEVNAME Show adapter statistics
        ethtool -n|-u|--show-nfc|--show-ntuple DEVNAME  Show Rx network flow classification options or rules
                [ rx-flow-hash tcp4|udp4|ah4|esp4|sctp4|tcp6|udp6|ah6|esp6|sctp6 |
                  rule %d ]
        ethtool -N|-U|--config-nfc|--config-ntuple DEVNAME      Configure Rx network flow classification options or rules
                rx-flow-hash tcp4|udp4|ah4|esp4|sctp4|tcp6|udp6|ah6|esp6|sctp6 m|v|t|s|d|f|n|r... |
                flow-type ether|ip4|tcp4|udp4|sctp4|ah4|esp4
                        [ src %x:%x:%x:%x:%x:%x [m %x:%x:%x:%x:%x:%x] ]
                        [ dst %x:%x:%x:%x:%x:%x [m %x:%x:%x:%x:%x:%x] ]
                        [ proto %d [m %x] ]
                        [ src-ip %d.%d.%d.%d [m %d.%d.%d.%d] ]
                        [ dst-ip %d.%d.%d.%d [m %d.%d.%d.%d] ]
                        [ tos %d [m %x] ]
                        [ l4proto %d [m %x] ]
                        [ src-port %d [m %x] ]
                        [ dst-port %d [m %x] ]
                        [ spi %d [m %x] ]
                        [ vlan-etype %x [m %x] ]
                        [ vlan %x [m %x] ]
                        [ user-def %x [m %x] ]
                        [ dst-mac %x:%x:%x:%x:%x:%x [m %x:%x:%x:%x:%x:%x] ]
                        [ action %d ]
                        [ loc %d]] |
                delete %d
        ethtool -T|--show-time-stamping DEVNAME Show time stamping capabilities
        ethtool -x|--show-rxfh-indir DEVNAME    Show Rx flow hash indirection
        ethtool -X|--set-rxfh-indir DEVNAME     Set Rx flow hash indirection
                equal N | weight W0 W1 ...
        ethtool -f|--flash DEVNAME      Flash firmware image from the specified file to a region on the device
               FILENAME [ REGION-NUMBER-TO-FLASH ]
        ethtool -P|--show-permaddr DEVNAME      Show permanent hardware address
        ethtool -w|--get-dump DEVNAME   Get dump flag, data
                [ data FILENAME ]
        ethtool -W|--set-dump DEVNAME   Set dump flag of the device
                N
        ethtool -l|--show-channels DEVNAME      Query Channels
        ethtool -L|--set-channels DEVNAME       Set Channels
               [ rx N ]
               [ tx N ]
               [ other N ]
               [ combined N ]
        ethtool --show-priv-flags DEVNAME       Query private flags
        ethtool --set-priv-flags DEVNAME        Set private flags
                FLAG on|off ...
        ethtool -m|--dump-module-eeprom|--module-info DEVNAME   Query/Decode Module EEPROM information and optical diagnostics if available
                [ raw on|off ]
                [ hex on|off ]
                [ offset N ]
                [ length N ]
        ethtool --show-eee DEVNAME      Show EEE settings
        ethtool --set-eee DEVNAME       Set EEE settings
                [ eee on|off ]
                [ advertise %x ]
                [ tx-lpi on|off ]
                [ tx-timer %d ]
        ethtool -h|--help               Show this help
        ethtool --version               Show version number
```

