# CMake 指定编译器为gcc/clang





## 方法一

- 使用gcc

```bash
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++
# cmake .. && make
```

- 使用clang

```bash
export CC=/usr/bin/clang++
export CXX=/usr/bin/clang++
# cmake .. && make
```

## 方法二

在CMakeLists.txt中类似如下的修改即可

**注意，一定要写在project指令之前，否则无效。**

```cmake
SET(CMAKE_C_COMPILER /usr/bin/gcc)
SET(CMAKE_CXX_COMPILER /usr/bin/g++)
```

## 方法三
使用toolchain.cmake 脚本