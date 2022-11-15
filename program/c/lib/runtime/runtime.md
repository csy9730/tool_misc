# runtime


|os|运行时库|编译器|编程语言||
|----|---|---|---|---|
|linux|libc|gcc|c|
|linux|libstdc++|g++|c++|
|----|libc++|llvm|---|
|----|libc++|clang|---|
|windows|libc.lib| VC|c|release static single-thread|
|windows|libcd.lib| VC|c|debug static single-thread|
|windows|libcp.lib| VC|c++|release static single-thread|
|windows|libcpd.lib| VC|c++|debug static single-thread|
|windows|msvcrt.lib msvcrt.dll|vc++1.0~vc++6.0| c++|release dynamic|
|windows|msvcrtd.lib msvcrtd.dll|vc++1.0~vc++6.0| c++|debug dynamic|
|windows|libcmt.lib| VS|c|release static mult-thread|
|windows|libcmtd.lib|VS |c|debug static|
|windows|LIBCPMT.lib| VS|c++|release static|
|windows|LIBCPMTD.lib|VS |c++|debug static|
|windows|msvcr.lib msvcr100.dll|VS2002~VS2013 |c|release dynamic|
|windows|msvcrd.lib msvcrd100.dll|VS2002~VS2013 |c|debug dynamic|
|windows|MSVCPRT.lib msvcp100.dll|VS2002~VS2013 |c++|release dynamic|
|windows|MSVCPRTd.lib msvcpd100.dll|VS2002~VS2013 |c++|debug dynamic|
|windows| libucrt.lib ucrt.lib ucrtbase.dll|VS2015|---|release dynamic|
|windows| libucrtd.lib ucrtd.lib ucrtbased.dll|VS2015|---|debug dynamic|
|windows| libucrt.lib |VS2015|---|release static|
|windows| libucrtd.lib |VS2015|---|debug static|
#### MSVCR100.dll

This msvcr100.dll is the Microsoft Visual C++ Redistributable dll that is needed for projects built with Visual Studio 2010. The dll letters spell this out.

MS = Microsoft
V = Visual
C = C program language
R = Run-time
100 = Version

If you create a C++ project in Visual Studio 2010, this file is probably needed.

#### MSVCP100.dll
This msvcp100.dll is the Microsoft Visual C++ Redistributable dll that is needed for projects built with Visual Studio 2010. The dll letters spell this out.

MS = Microsoft
V = Visual
CP = C++
100 = version

If you create a C++ project in Visual Studio 2010, this file is probably needed.

## misc
### reference
[crt-library-features](https://learn.microsoft.com/en-us/cpp/c-runtime-library/crt-library-features?view=msvc-170)