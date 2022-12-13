# 使用minicom基于串口传输文件



linux系统下，需要通过串口和板子传输文件，可以通过minicom和lrzsz。

0. pc上交叉编译lrzsz，板子上安装lrzsz
1. pc上安装minicom， `apt install minicom`
2. 运行`minicom -s`，配置串口号，保存配置文件
3. 运行`minicom`，确保minicom和板子成功连接
4. pc上发送文件到板子：
   0. 运行`minicom -s`, 配置文件收发路径
   1. minicom中，运行 `rz` 命令， 板子准备接收文件
   2. minicom中，运行`ctrl+a s`命令，pc执行发送文件
   3. 在文件接收路径，确认文件传输成功
5. 板子中发送文件到pc：
   1. 运行`minicom -s`, 配置文件收发路径
   2. minicom中，运行 `sz foo`命令， 板子发送文件
   3. minicom中，自动运行`ctrl+a r`命令，pc执行接收文件。
   4. 在文件接收路径，确认文件传输成功


该方法适用于linux系统，windows的wsl也适用。

sz和lsz两个命令等效，rz和lrz两个命令等效。


#### 配置文件
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
