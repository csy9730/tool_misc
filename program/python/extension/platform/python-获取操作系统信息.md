# [python-获取操作系统信息](https://www.cnblogs.com/black-mamba/p/7061352.html)

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)



```python
#!/usr/bin/env python
#-*- coding:utf-8 -*-
############################
#File Name: test_platform.py
#Author: frank
#Mail: frank0903@aliyun.com
#Created Time:2017-06-05 14:31:31
############################

import platform 
os = platform.system()
print os
print platform.platform()
print platform.version()
print platform.architecture()

'''
    python中，platform模块给我们提供了很多方法去获取操作系统的信息
    如：
        import platform
        platform.platform()        #获取操作系统名称及版本号，'Linux-3.13.0-46-generic-i686-with-Deepin-2014.2-trusty'  
        platform.version()         #获取操作系统版本号，'#76-Ubuntu SMP Thu Feb 26 18:52:49 UTC 2015'
        platform.architecture()    #获取操作系统的位数，('32bit', 'ELF')
        platform.machine()         #计算机类型，'i686'
        platform.node()            #计算机的网络名称，'XF654'
        platform.processor()       #计算机处理器信息，''i686'
        platform.uname()           #包含上面所有的信息汇总，('Linux', 'XF654', '3.13.0-46-generic', '#76-Ubuntu SMP Thu Feb 26 18:52:49 UTC 2015', 'i686', 'i686')

        还可以获得计算机中python的一些信息：
        import platform
        platform.python_build()
        platform.python_compiler()
        platform.python_branch()
        platform.python_implementation()
        platform.python_revision()
        platform.python_version()
        platform.python_version_tuple()
'''

#global var
#是否显示日志信息
SHOW_LOG = True

def get_platform():
    '''获取操作系统名称及版本号'''
    return platform.platform()

def get_version():
    '''获取操作系统版本号'''
    return platform.version()

def get_architecture():
    '''获取操作系统的位数'''
    return platform.architecture()

def get_machine():
    '''计算机类型'''
    return platform.machine()

def get_node():
    '''计算机的网络名称'''
    return platform.node()

def get_processor():
    '''计算机处理器信息'''
    return platform.processor()

def get_system():
    '''获取操作系统类型'''
    return platform.system()

def get_uname():
    '''汇总信息'''
    return platform.uname()

def get_python_build():
    ''' the Python build number and date as strings'''
    return platform.python_build()

def get_python_compiler():
    '''Returns a string identifying the compiler used for compiling Python'''
    return platform.python_compiler()

def get_python_branch():
    '''Returns a string identifying the Python implementation SCM branch'''
    return platform.python_branch()

def get_python_implementation():
    '''Returns a string identifying the Python implementation. Possible return values are: ‘CPython’, ‘IronPython’, ‘Jython’, ‘PyPy’.'''
    return platform.python_implementation()

def get_python_version():
    '''Returns the Python version as string 'major.minor.patchlevel'
    '''
    return platform.python_version()

def get_python_revision():
    '''Returns a string identifying the Python implementation SCM revision.'''
    return platform.python_revision()

def get_python_version_tuple():
    '''Returns the Python version as tuple (major, minor, patchlevel) of strings'''
    return platform.python_version_tuple()

def show_os_all_info():
    '''打印os的全部信息'''
    print('获取操作系统名称及版本号 : [{}]'.format(get_platform()))
    print('获取操作系统版本号 : [{}]'.format(get_version()))
    print('获取操作系统的位数 : [{}]'.format(get_architecture()))
    print('计算机类型 : [{}]'.format(get_machine()))
    print('计算机的网络名称 : [{}]'.format(get_node()))
    print('计算机处理器信息 : [{}]'.format(get_processor()))
    print('获取操作系统类型 : [{}]'.format(get_system()))
    print('汇总信息 : [{}]'.format(get_uname()))

def show_os_info():
    '''只打印os的信息，没有解释部分'''
    print(get_platform())
    print(get_version())
    print(get_architecture())
    print(get_machine())
    print(get_node())
    print(get_processor())
    print(get_system())
    print(get_uname())

def show_python_all_info():
    '''打印python的全部信息'''
    print('The Python build number and date as strings : [{}]'.format(get_python_build()))
    print('Returns a string identifying the compiler used for compiling Python : [{}]'.format(get_python_compiler()))
    print('Returns a string identifying the Python implementation SCM branch : [{}]'.format(get_python_branch()))
    print('Returns a string identifying the Python implementation : [{}]'.format(get_python_implementation()))
    print('The version of Python ： [{}]'.format(get_python_version()))
    print('Python implementation SCM revision : [{}]'.format(get_python_revision()))
    print('Python version as tuple : [{}]'.format(get_python_version_tuple()))

def show_python_info():
    '''只打印python的信息，没有解释部分'''
    print(get_python_build())
    print(get_python_compiler())
    print(get_python_branch())
    print(get_python_implementation())
    print(get_python_version())
    print(get_python_revision())
    print(get_python_version_tuple())
      
def test():
    print('操作系统信息:')
    if SHOW_LOG:
        show_os_all_info()
    else:
        show_os_info()
    print('#' * 50)
    print('计算机中的python信息：')
    if SHOW_LOG:
        show_python_all_info()
    else:
        show_python_info()

def init():
    global SHOW_LOG
    SHOW_LOG = True
    
def main():
    init()
    test()

if __name__ == '__main__':
    main()
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

### misc

``` python
# windows pc
>>> platform.uname()
uname_result(system='Windows', node='DESKTOP-PGB2SME', release='10', version='10.0.18362', machine='AMD64', processor='Intel64 Family 6 Model 158 Stepping 12, GenuineIntel')

# windows pc wsl
>>> platform.uname()
uname_result(system='Linux', node='DESKTOP-PGB2SME', release='4.4.0-18362-Microsoft', version='#476-Microsoft Fri Nov 01 16:53:00 PST 2019', machine='x86_64', processor='x86_64')
   
#   DS918Plus pc  
>>> platform.uname()
('Linux', 'DS918Plus', '4.4.59+', '#23824 SMP PREEMPT Tue Feb 12 16:52:55 CST 2019', 'x86_64', '')

# android phone
>>> platform.uname()
uname_result(system='Linux', node='localhost', release='5.10.66-android12-9-00001-gd17792b2748e-ab8229266', version='#1 SMP PREEMPT Fri Mar 11 03:13:00 UTC 2022', machine='aarch64')

# android pad
>>> platform.uname()
uname_result(system='Linux', node='localhost', release='4.19.95-perf+', version='#1 SMP PREEMPT Wed Oct 21 13:48:09 CST 2020', machine='aarch64')

# linux phone
>>> platform.uname()
('Linux', 'M1808', '4.4.194', '#13 SMP PREEMPT Thu Nov 12 16:48:13 CST 2020', 'aarch64', '')

# linux raspberrypi
>>> platform.uname()
uname_result(system='Linux', node='raspberrypi', release='4.19.66-v7+', version='#1253 SMP Thu Aug 15 11:49:46 BST 2019', machine='armv7l', processor='')
>>>

# linux vmware linux
uname_result(system='Linux', node='iZwz9byzx08gpm6z3dd7fjZ', release='3.10.0-1160.14.3.el7.x86_64', version='#1 SMP Wed Feb 3 15:06:38 UTC 2021', machine='x86_64', processor='x86_64')
>>>

```



分类: [python](https://www.cnblogs.com/black-mamba/category/1007684.html)



