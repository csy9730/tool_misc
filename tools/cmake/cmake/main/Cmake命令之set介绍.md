# Cmake命令之set介绍

[![img](https://upload.jianshu.io/users/upload_avatars/11416464/294609d1-eda4-4ec3-a417-11e566f37cd9.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)](https://www.jianshu.com/u/1db645bebea6)

[Domibaba](https://www.jianshu.com/u/1db645bebea6)关注

0.2112020.09.08 04:08:29字数 2,317阅读 18,506

- #### 命令格式

  > `set`(<variable> <value>... [`PARENT_SCOPE`]) `#设置普通变量`
  > `set`(<variable> <value>... `CACHE` <type> <docstring> [`FORCE`]) `#设置缓存条目`
  > `set`(`ENV`{<variable>} [<value>]) `#设置环境变量`

    `set`命令可以设置普通变量、缓存条目、环境变量三种变量的值，分别对应上述三种命令格式。`set`的值`...`表示可以给变量设置0个或者多个值，当设置多个值时（大于2个），多个值会通过`分号连接符`连接成一个真实的值赋值给变量，当设置0个值时，实际上是把变量变为未设置状态，相当于调用`unset`命令。

- #### 命令解析

  下面分别对三种变量的设置进行说明。

  ##### **1. 设置普通变量**

    **命令格式**：`set`(<variable> <value>... [`PARENT_SCOPE`])
    **命令含义**：将变量`variable`设置为值`...`，变量`variable`的`作用域`为调用`set`命令的函数或者当前目录，如果使用了`PARENT_SCOPE`选项，意味着该变量的作用域会传递到上一层（也就是上一层目录或者当前函数的调用者，如果是函数则传递到函数的调用者，如果是目录则传递到上一层目录），并且在当前作用域该变量不受`带PARENT_SCOPE`选项的`set`命令的影响（如果变量之前没有定义，那么在当前作用域仍然是无定义的；如果之前有定义值，那么值和之前定义的值保持一致）。
    **关于变量的`作用域`**：每一个新的目录或者函数都会创建一个新的作用域，普通变量的作用域，如果不使用`PARENT_SCOPE`选项，只能从外层往内层传递。

  - 1）先来看最常用的用法，设置变量为一个给定的值

  

  ```bash
  cmake_minimum_required (VERSION 3.10.2)
  project (set_test)
  set (normal_var a)
  message (">>> value = ${normal_var}")
  ```

    输出为：

  

  ```ruby
  >>> value = a
  ```

  - 2）设置变量为多个给定的值

  

  ```bash
  cmake_minimum_required (VERSION 3.10.2)
  project (set_test)
  set (normal_var a b c)
  message (">>> value = ${normal_var}")
  ```

    输出为：

  

  ```ruby
  >>> value = a;b;c
  ```

    可以看到多个值被`;`号连接最终的值之后赋给变量。

  - 3）设置变量为空

  

  ```bash
  cmake_minimum_required (VERSION 3.10.2)
  project (set_test)
  set (normal_var a b c)
  message (">>> value = ${normal_var}")
  set (normal_var) # 设置变量为空
  message (">>> value = ${normal_var}")
  ```

    输出为：

  

  ```ruby
  >>> value = a;b;c
  >>> value =
  ```

  - 4）在函数内使用选项

    ```
    PARENT_SCOPE
    ```

    ，对应的作用域只能传递到调用它的函数。

    场景1

    ：在函数内使用选项

    ```
    PARENT_SCOPE
    ```

    定义变量，在函数定义的文件中（非另一个函数中）使用该变量。

    结果：

    变量无定义。

    结论：

    函数内定义的变量，在函数定义的文件中调用，找不到变量的定义。

    

    ```php
    # CMakeLists.txt
    cmake_minimum_required (VERSION 3.10.2)
    project (set_test)
    
    function (test_fn arg1)
        set (normal_var_in_fn ${arg1} PARENT_SCOPE)
    endfunction (test_fn)
    message (">>> in directory, value = ${normal_var_fn}")
    ```

    

    ```csharp
    # 输出
    >>> in directory, value =
    >>> in function, value =
    ```

    场景2

    ：在函数内使用选项

    ```
    PARENT_SCOPE
    ```

    定义变量，在函数内使用该变量。

    结果：

    变量无定义。

    结论：

    函数内使用选项

    ```
    PARENT_SCOPE
    ```

    定义的变量，在函数内也是无定义的。

    

    ```php
    # CMakeLists.txt
    cmake_minimum_required (VERSION 3.10.2)
    project (set_test)
    
     function (test_fn arg1)
        set (normal_var_in_fn ${arg1} PARENT_SCOPE)
        message (">>> in function, value = ${normal_var_fn}")
    endfunction (test_fn)
    
    test_fn (hello)
    ```

    

    ```ruby
    # 输出
    >>> in function, value =
    ```

    场景3

    ：在函数内使用选项

    ```
    PARENT_SCOPE
    ```

    定义变量，在函数内使用该变量，并且使用

    ```
    set
    ```

    命令

    ```
    不带PARENT_SCOPE
    ```

    选项定义过该变量。

    结果：

    函数内的变量值为

    ```
    不带PARENT_SCOPE
    ```

    选项的

    ```
    set
    ```

    命令所定义的。

    结论：

    选项

    ```
    PARENT_SCOPE
    ```

    定义的变量作用域在上一层函数，当前函数的变量必须使用不带选项

    ```
    PARENT_SCOPE
    ```

    定义。

    

    ```php
    # CMakeLists.txt
    cmake_minimum_required (VERSION 3.10.2)
    project (set_test)
    
    function (test_fn arg1)
        set (normal_var_in_fn nohello)
        set (normal_var_in_fn ${arg1} PARENT_SCOPE)
        message (">>> in function, value = ${normal_var_in_fn}")
    endfunction (test_fn)
    test_fn (hello)
    ```

    

    ```ruby
    # 输出
    >>> in function, value = nohello
    ```

    场景4

    ：在函数（示例中为

    ```
    test_fn
    ```

    ）内使用选项

    ```
    PARENT_SCOPE
    ```

    定义变量，在另一个函数（调用者，示例中为

    ```
    test_fn_parent
    ```

    ）内调用该函数。

    结果：

    调用者函数内有该变量的定义。

    结论：

    选项

    ```
    PARENT_SCOPE
    ```

    将变量传递到上一层调用函数。

    

    ```php
    # CMakeLists.txt
    cmake_minimum_required (VERSION 3.10.2)
    project (set_test)
    
    function (test_fn arg1)
        set (normal_var_in_fn nohello)
        set (normal_var_in_fn ${arg1} PARENT_SCOPE)
        message (">>> in function, value = ${normal_var_in_fn}")
    endfunction (test_fn)
    
    function (test_fn_parent arg1)
        test_fn (${arg1})
        message (">>> in parent function, value = ${normal_var_in_fn}")
    endfunction (test_fn_parent)
    
    test_fn_parent (hello)
    ```

    

    ```ruby
    # 输出
    >>> in function, value = nohello
    >>> in parent function, value = hello
    ```

  - 5）在目录内使用选项

    ```
    PARENT_SCOPE
    ```

    ，对应的作用域只能传递到上层目录，变量的传递过程与4）中函数的场景类似，不再赘述。注意一点：本例在

    ```
    test
    ```

    和

    ```
    test/sub
    ```

    下分别创建一个

    ```
    CMakeLists.txt
    ```

    文件。

    示例如下：

    

    ```bash
    # test/sub/CMakeLists.txt
    cmake_minimum_required (VERSION 3.10.2)
    project (set_sub_test)
    
    set (normal_var_in_sub_dir sub_hello)
    set (normal_var_in_sub_dir hello PARENT_SCOPE)
    
    message (">>>>>> in sub directory, value = ${normal_var_in_sub_dir}")
    ```

    

    ```bash
    # test/CMakeLists.txt
    cmake_minimum_required (VERSION 3.10.2)
    project (set_test)
    
    add_subdirectory (sub)
    
    message (">>> in top level, value = ${normal_var_in_sub_dir}")
    ```

    

    ```ruby
    # 输出
    >>>>>> in sub directory, value = sub_hello
    >>> in top level, value = hello
    ```

  ##### **2. 设置缓存条目**

    **命令格式**：`set`(<variable> <value>... `CACHE` <type> <docstring> [`FORCE`])
    **命令含义**：将缓存条目`variable`设置为值`...`，除非用户进行设置或使用了选项`FORCE`，默认情况下缓存条目的值不会被覆盖。缓存条目可以通过CMAKE的GUI界面的`add entry`按钮来增加。缓存条目的实质为可以跨层级进行传递的变量，类似于全局变量。
    缓存条目的``主要有以下几类：

  - `BOOL`：布尔值`ON/OFF`,CMAKE的GUI界面对此类缓存条目会提供一个复选框。

  - `FILEPATH`：文件路径，CMAKE的GUI界面对此类缓存条目会提供一个文件选择框。

  - `PATH`：目录路径，CMAKE的GUI界面对此类缓存条目会提供一个目录选择框。

  - `STRING / STRINGS`：文本行，CMAKE的GUI界面对此类缓存条目会提供一个文本框（对应`STRING`）或下拉选择框（对应`STRINGS`）。

  - ```
    INTERNAL
    ```

    ：文本行，但是只用于内部，不对外呈现。主要用于运行过程中存储变量，因此使用该

    ```
    type
    ```

    意味着使用

    ```
    FORCE
    ```

    。

      缓存条目的几个注意事项：

    1）如果变量先前未定义或者使用了

    ```
    FORCE
    ```

    选项，则缓存条目会直接被赋值。

    2）可以在使用cmake构建的使用通过

    ```
    -D
    ```

    选项来给缓存条目赋值，这样CMakeLists.txt内的

    ```
    set
    ```

    命令只会为缓存条目添加类型。

    3）如果变量类型是目录或者文件路径，通过

    ```
    -D
    ```

    选项传入的若只是相对路径，那么

    ```
    set
    ```

    会给这个相对路径前添加当前的工作目录以变成绝对路径（如果已经是绝对路径则不会处理）。

    

    ```bash
    # CMakeLists.txt
    cmake_minimum_required (VERSION 3.10.2)
    project (set_test)
    
    set (cache_entry_val ON OFF CACHE BOOL "choose ON to enable")
    message (">>> value = ${cache_entry_val}")
    
    set (cache_entry_val2 ON CACHE BOOL "choose ON to enable" FORCE)
    message (">>> value2 = ${cache_entry_val2}")
    
    set (cache_entry_val3 ON)
    set (cache_entry_val3 OFF CACHE BOOL "choose ON to enable")
    message (">>> value3 = ${cache_entry_val3}")
    
    set (cache_entry_input OFF CACHE BOOL "choose ON to enable")
    message (">>> value4 = ${cache_entry_input}")
    
    set (mypath "test" CACHE FILEPATH "choose a file path")
    message (">>> value5 = ${mypath}")
    ```

    

    ```ruby
    # 输入cmake构建，使用-D选项
    cmake . -Dcache_entry_input=ON -Dmypath=sub
    
    # 输出
    >>> value = ON;OFF
    >>> value2 = ON
    >>> value3 = ON
    >>> value4 = ON
    >>> value5 = /XXX/XXX/XXX/sub
    ```

  ##### **3. 设置环境变量**

    **命令格式**：`set`(`ENV`{<variable>} [<value>])
    **命令含义**：将环境变量设置为值``（注意没有`...`），接着使用`$ENV{}`会得到新的值。cmake中的环境变量可以参考：[环境变量](https://links.jianshu.com/go?to=https%3A%2F%2Fcmake.org%2Fcmake%2Fhelp%2Flatest%2Fmanual%2Fcmake-env-variables.7.html%23manual%3Acmake-env-variables(7))。
    环境变量设置的几个注意事项：
  1）该命令设置的环境变量只在当前的cmake进程生效，既不会影响调用者的环境变量，也不会影响系统环境变量。
  2）如果``值为空或者`ENV{}`后没有参数，则该命令会清除掉当前环境变量的值。
  3）``后的参数会被忽略。

  

  ```bash
  # CMakeLists.txt
  cmake_minimum_required (VERSION 3.10.2)
  project (set_test)
  
  message (">>> value = $ENV{CMAKE_PREFIX_PATH}")
  set (ENV{CMAKE_PREFIX_PATH} "/test/sub")
  message (">>> value = $ENV{CMAKE_PREFIX_PATH}")
  set (ENV{CMAKE_PREFIX_PATH})
  message (">>> value = $ENV{CMAKE_PREFIX_PATH}")
  set (ENV{CMAKE_PREFIX_PATH} "/test/top/") 
  message (">>> value = $ENV{CMAKE_PREFIX_PATH}")
  set (ENV{CMAKE_PREFIX_PATH} "") 
  message (">>> value = $ENV{CMAKE_PREFIX_PATH}")
  ```

  

  ```ruby
  # 输出
  >>> value =
  >>> value = /test/sub
  >>> value =
  >>> value = /test/top
  >>> value =
  ```

 

------

## 附录：参考资料

1. [https://cmake.org/cmake/help/latest/command/set.html](https://links.jianshu.com/go?to=https%3A%2F%2Fcmake.org%2Fcmake%2Fhelp%2Flatest%2Fcommand%2Fset.html)
2. [https://cmake.org/cmake/help/latest/manual/cmake-env-variables.7.html#manual:cmake-env-variables(7)](https://links.jianshu.com/go?to=https%3A%2F%2Fcmake.org%2Fcmake%2Fhelp%2Flatest%2Fmanual%2Fcmake-env-variables.7.html%23manual%3Acmake-env-variables(7))