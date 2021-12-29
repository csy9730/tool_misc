# matlab.engine

从Python中调用MATLAB

用于Python的MATLAB引擎API可以将MATLAB称为计算引擎，因此我们可以在Python中使用自己想用的MATLAB函数。
## install
首先，我们需要通过MATLAB随附的Python软件包进行安装。在操作系统提示符下执行以下命令：
```
 $ cd "${matlabroot}/extern/engines/python"
 $ python setup.py install
```

## demo
``` python
#coding=utf-8
import matlab.engine
from numpy import *

if __name__ == '__main__':
    eng = matlab.engine.start_matlab()
    A = matlab.double([[1,2],[5,6]])
    print(type(A),A.size,A)
    print(eng.eig(A))
    eng.quit()
    pass
```

## misc

### OSError: MATLAB Engine for Python supports Python version 2.7, 3.5 and 3.6 but your version of Python is 3.7

关注

108 次查看（过去 30 天）


[![JSO CI Team Veoneer](https://ww2.mathworks.cn/responsive_image/100/100/0/0/0/cache/matlabcentral/profiles/15503045_1557975376184_DEF.jpg)](https://ww2.mathworks.cn/matlabcentral/profile/authors/15503045)

[JSO CI Team Veoneer](https://ww2.mathworks.cn/matlabcentral/profile/authors/15503045) ，2020-3-27

- 1
-  翻译

[评论：](https://ww2.mathworks.cn/matlabcentral/answers/513289-oserror-matlab-engine-for-python-supports-python-version-2-7-3-5-and-3-6-but-your-version-of-pytho#comment_1578115) [Steven Lord](https://ww2.mathworks.cn/matlabcentral/profile/authors/493281)   ，2021-6-11

[采纳的回答：](https://ww2.mathworks.cn/matlabcentral/answers/513289-oserror-matlab-engine-for-python-supports-python-version-2-7-3-5-and-3-6-but-your-version-of-pytho#accepted_answer_422353) [Steven Lord](https://ww2.mathworks.cn/matlabcentral/profile/authors/493281)  



We recently installed Python 3.7.2.

Matlab engine was working with the earlier 2.7, but now when we try installing the engine, getting the below error.

"OSError: MATLAB Engine for Python supports Python version 2.7, 3.5 and 3.6 but your version of Python is 3.7"

Although, Matlab supported versions indicates that 3.7 is supported, the "setup.py" does not seem to have 3.7 in the supported versions. 

Where can I download the latest setup.py.

Is modifying the setup.py to include 3.7 sufficient ? 