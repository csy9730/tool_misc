# minicom


## help 
ctrl+a q 退出

ctrl+a x 退出程序




### 配置文件
输入 `minicom -s`
```
    +-----[configuration]------+
    | Filenames and paths      |
    | File transfer protocols  |
    | Serial port setup        |
    | Modem and dialing        |
    | Screen and keyboard      |
    | Save setup as dfl        |
    | Save setup as..          |
    | Exit                     |
    | Exit from Minicom        |
    +--------------------------+
```            


#### Serial port setup
配置文件, 选择 "Serial port setup"
```
    +-----------------------------------------------------------------------+
    | A -    Serial Device      : /dev/ttyS3                                |
    | B - Lockfile Location     : /var/lock                                 |
    | C -   Callin Program      :                                           |
    | D -  Callout Program      :                                           |
    | E -    Bps/Par/Bits       : 115200 8N1                                |
    | F - Hardware Flow Control : No                                        |
    | G - Software Flow Control : No                                        |
    | H -     RS485 Enable      : No                                        |
    | I -   RS485 Rts On Send   : No                                        |
    | J -  RS485 Rts After Send : No                                        |
    | K -  RS485 Rx During Tx   : No                                        |
    | L -  RS485 Terminate Bus  : No                                        |
    | M - RS485 Delay Rts Before: 0                                         |
    | N - RS485 Delay Rts After : 0                                         |
    |                                                                       |
    |    Change which setting?                                              |
    +-----------------------------------------------------------------------+
```    

#### 配置文件收发路径
配置文件, 选择 "Filenames and paths"

```
    +-----------------------------------------------------------------------+
    | A - Download directory : /tmp                                         |
    | B - Upload directory   : /tmp                                         |
    | C - Script directory   :                                              |
    | D - Script program     : runscript                                    |
    | E - Kermit program     :                                              |
    | F - Logging options                                                   |
    |                                                                       |
    |    Change which setting?                                              |
    +-----------------------------------------------------------------------+
```

A对应

### Minicom Command
串口连接成功后，可以使用特殊的命令功能。

#### Minicom Command

查看所有的命令。
``` 
 +-------------------------------------------------------------------+
 |                      Minicom Command Summary                      |
 |                                                                   |
 |              Commands can be called by CTRL-A <key>               |
 |                                                                   |
 |               Main Functions                  Other Functions     |
 |                                                                   |
 | Dialing directory..D  run script (Go)....G | Clear Screen.......C |
 | Send files.........S  Receive files......R | cOnfigure Minicom..O |
 | comm Parameters....P  Add linefeed.......A | Suspend minicom....J |
 | Capture on/off.....L  Hangup.............H | eXit and reset.....X |
 | send break.........F  initialize Modem...M | Quit with no reset.Q |
 | Terminal settings..T  run Kermit.........K | Cursor key mode....I |
 | lineWrap on/off....W  local Echo on/off..E | Help screen........Z |
 | Paste file.........Y  Timestamp toggle...N | scroll Back........B |
 | Add Carriage Ret...U                                              |
 |                                                                   |
 |             Select function or press Enter for none.              |
 +-------------------------------------------------------------------+
```


#### Send files
```
-[Upload]--+
| zmodem    |
| ymodem    |
| xmodem    |
| kermit    |
| ascii     |
+-----------+
```

Upload   pc上传文件到板子，pc上传文件夹路径。
#### Receive files

Download, 板子下载到pc， pc的保存路径。
```
+-[Download]--+
| zmodem      |
| ymodem      |
| xmodem      |
| kermit      |
+-------------+
```