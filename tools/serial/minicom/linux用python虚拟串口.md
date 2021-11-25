# [linux用python虚拟串口](https://www.cnblogs.com/pied/p/4147094.html)

在linux下调试串口程序，无奈下面的硬件还没到位，所以，想着自己模拟一个串口用用。试了下下面这段代码：

``` python
#!/usr/bin/env python
#coding=utf-8

import pty
import os
import select

def mkpty():
#Open a new tty
        master1, slave = pty.openpty()
        slaveName1 = os.ttyname(slave)
        master2, slave = pty.openpty()
        slaveName2 = os.ttyname(slave)

        print '\nslave device names:', slaveName1, slaveName2
        return master1, master2

if __name__ == "__main__":

        master1, master2 = mkpty()
        while True:
        #       rl=read list, wait until ready to reading 
        #       wl=write list, wait until ready to writing
        #       el=exception list, wait for an "exceptional condition"
        #       timeout = 1s
                rl, wl, el = select.select([master1, master2], [], [], 1)
                for device in rl:
                        data = os.read(device, 128)
                        print "read %d data."%len(data)
                        if device == master1:
                                os.write(master2, data)
                        else:
                                os.write(master1, data)
```


pty是假串口的意思，但是支持硬件串口的所有操作。so。。。

另外一个，模拟同事通过串口发来的数据。所有写到master的数据，都被自动的发往slave。所以，我们在slave这边就可以收到想要的数据。


``` python
#!/usr/bin/env python
#coding=utf-8

import pty
import os
import time
import array
import random

def mkpty():
    #make pair of pseudo tty
    master, slave = pty.openpty()
    slaveName = os.ttyname(slave)

    print '\nslave device names:', slaveName
    return master

if __name__ == "__main__":
    master = mkpty()
    buf = array.array('B', [0] * 7)
    buf[0] = 0x00
    buf[1] = 0x02
    buf[2] = 0x8a
    buf[3] = 0x2d
    buf[4] = 0xc5
    buf[5] = 0x3f
    buf[6] = 0x00

    while True:
        if buf[1] < 40:
            buf[1] = buf[1] + 1
        else:
            buf[1] = 1
            buf[0] = buf[0] + 1

        if buf[0] == 255:
            buf[0] = 0

#        buf[5] = random.randint(40,50)
        buf[2] = random.randint(0,250)
        buf[6] = ( buf[0]+buf[1]+buf[2]+buf[3]+buf[4]+buf[5]) %256
        os.write(master,  buf)
#        print buf
        time.sleep(0.02)        
```

——————
无论在哪里做什么，只要坚持服务、创新、创造价值，其他的东西自然都会来的。