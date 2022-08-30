# python.m

MATLAB中调用Python

要求MATLAB版本高于2014.

### pyversion
```
>> pyversion

       version: ''
    executable: ''
       library: ''
          home: ''
      isloaded: 0
```

#### 2
```
>> pyversion('f:\Anaconda3\python.exe')
>> pyversion

       version: '3.6'
    executable: 'f:\Anaconda3\python.EXE'
       library: 'f:\Anaconda3\python36.dll'
          home: 'f:\Anaconda3'
      isloaded: 0
```
### py.m
`toolbox/matlab/external/interfaces/python/py.m`
#### demo

最简单的调用方式是直接执行Python语句

```

>> py.print('Hello, Python!')
Hello, Python!

>> py.sys.path
ans = 
  Python list (不带属性)。
    ['', 'f:\\Anaconda3\\python36.zip', 'f:\\Anaconda3\\DLLs', ...]

>> py.list([1,2])
ans = 
  Python list (不带属性)。
    [1.0, 2.0]
```    