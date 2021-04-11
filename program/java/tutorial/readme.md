# readme



## misc


**Q**: 
```
D:\Projects>javac EmployeeTest.java
EmployeeTest.java:5: 错误: 编码 GBK 的不可映射字符 (0x80)
      /* 浣跨敤鏋勯?犲櫒鍒涘缓涓や釜瀵硅薄 */
              ^
EmployeeTest.java:11: 错误: 编码 GBK 的不可映射字符 (0x98)
      empOne.empDesignation("楂樼骇绋嬪簭鍛?");
                                    ^
EmployeeTest.java:16: 错误: 编码 GBK 的不可映射字符 (0x98)
      empTwo.empDesignation("鑿滈笩绋嬪簭鍛?");
                                    ^
3 个错误
```
**A**: java文件使用了utf8编码，需要转成gbk编码，或者在javac指定使用utf8编码。

```
D:\Projects>java EmployeeTest.class
错误: 找不到或无法加载主类 EmployeeTest.class
原因: java.lang.ClassNotFoundException: EmployeeTest.class
```

**A**: 不要画蛇添足增加class后缀， 直接`java EmployeeTest`即可

```
java HelloWorld
Error: A JNI error has occurred, please check your installation and try again
Exception in thread "main" java.lang.UnsupportedClassVersionError: HelloWorld has been compiled by a more recent version of the Java Runtime (class file version 55.0), this version of the
Java Runtime only recognizes class file versions up to 52.0
        at java.lang.ClassLoader.defineClass1(Native Method)
        at java.lang.ClassLoader.defineClass(Unknown Source)
        at java.security.SecureClassLoader.defineClass(Unknown Source)
        at java.net.URLClassLoader.defineClass(Unknown Source)
        at java.net.URLClassLoader.access$100(Unknown Source)
        at java.net.URLClassLoader$1.run(Unknown Source)
        at java.net.URLClassLoader$1.run(Unknown Source)
        at java.security.AccessController.doPrivileged(Native Method)
        at java.net.URLClassLoader.findClass(Unknown Source)
        at java.lang.ClassLoader.loadClass(Unknown Source)
        at sun.misc.Launcher$AppClassLoader.loadClass(Unknown Source)
        at java.lang.ClassLoader.loadClass(Unknown Source)
        at sun.launcher.LauncherHelper.checkAndLoadMain(Unknown Source)
```

**A**: javac 和 java 版本不匹配，需要使用相同版本。