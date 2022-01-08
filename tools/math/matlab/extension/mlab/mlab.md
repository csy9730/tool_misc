# mlab

[https://github.com/ewiger/mlab](https://github.com/ewiger/mlab)

mlab仓库的最后更新日期是2016年，基于python2，年久失修，不建议使用。
mlab的原理是后台交互式地运行matlab。该仓库较小。


mlab仓库参考了：[http://mlabwrap.sourceforge.net/](http://mlabwrap.sourceforge.net/)，
mlabwrap仓库的最后更新日期是2011年？

## install

```
pip install mlab
```
### misc
```
(base) D:\Projects\mylib\tool_misc>pip install mlab
Looking in indexes: https://mirrors.aliyun.com/pypi/simple/
Collecting mlab
  Downloading https://mirrors.aliyun.com/pypi/packages/84/44/c2bc56f1628299282c53717a8791ee2912e1e329343ef964fb723d760b46/mlab-1.1.4.tar.gz (49kB)
     |████████████████████████████████| 51kB 3.4MB/s
    ERROR: Command errored out with exit status 1:
     command: 'C:\ProgramData\Miniconda3\python.exe' -c 'import sys, setuptools, tokenize; sys.argv[0] = '"'"'C:\\Users\\admin\\AppData\\Local\\Temp\\pip-install-u2z_smrj\\mlab\\setup.py'"'"'; __file__='"'"'C:\\Users\\admin\\AppData\\Local\\Temp\\pip-install-u2z_smrj\\mlab\\setup.py'"'"';f=getattr(tokenize, '"'"'open'"'"', open)(__file__);code=f.read().replace('"'"'\r\n'"'"', '"'"'\n'"'"');f.close();exec(compile(code, __file__, '"'"'exec'"'"'))' egg_info --egg-base 'C:\Users\admin\AppData\Local\Temp\pip-install-u2z_smrj\mlab\pip-egg-info'
         cwd: C:\Users\admin\AppData\Local\Temp\pip-install-u2z_smrj\mlab\
    Complete output (7 lines):
    Traceback (most recent call last):
      File "<string>", line 1, in <module>
      File "C:\Users\admin\AppData\Local\Temp\pip-install-u2z_smrj\mlab\setup.py", line 38, in <module>
        long_description=readme(),
      File "C:\Users\admin\AppData\Local\Temp\pip-install-u2z_smrj\mlab\setup.py", line 20, in readme
        document = docutils.core.publish_doctree(f.read())
    UnicodeDecodeError: 'gbk' codec can't decode byte 0x99 in position 1945: illegal multibyte sequence
    ----------------------------------------
ERROR: Command errored out with exit status 1: python setup.py egg_info Check the logs for full command output.
```
该仓库不兼容python3，尝试使用python2.

```
ImportError: No module named win32com.client

```

```
pip install pywin32
```

## demo
### 1
``` python
from mlab.releases import latest_release as matlab
import numpy as np

x = np.arange(-2*np.pi, 2*np.pi, 0.2)
matlab.surf(np.subtract.outer(np.sin(x),np.cos(x)))
```

## source

### core
#### unix
> Only unix (or mac osx) versions of Matlab support pipe communication

核心代码是：`matlab -nojvm -nodesktop`

``` python
class MatlabPipe(object):
    """ Manages a connection to a matlab process."""
    def open(self, print_matlab_welcome=False):
        self.process = subprocess.Popen(
                [self.matlab_process_path, '-nojvm', '-nodesktop'],
                stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
```
#### windows
> The module sends commands to the matlab process as a COM client. This is only supported under windows.

``` python
class MatlabCom(object):
  """ Manages a matlab COM client.

  The process can be opened and close with the open/close methods.
  To send a command to the matlab shell use 'eval'.
  To load numpy data to the matlab shell use 'put'.
  To retrieve numpy data from the matlab shell use 'get'.
  """
  def __init__(self, matlab_process_path=None, matlab_version=None):
    self.client = None

  def open(self, visible=False):
    """ Dispatches the matlab COM client.

    Note: If this method fails, try running matlab with the -regserver flag.
    """
    if self.client:
      raise MatlabConnectionError('Matlab(TM) COM client is still active. Use close to '
                      'close it')
    self.client = win32com.client.Dispatch('matlab.application')
    self.client.visible = visible
```
