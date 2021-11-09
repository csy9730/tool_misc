# toolchain

toolchain文件保存了工具链配置。包括gcc，g++文件路径。

cmake可以导入toolchain的配置。

### toolchains

cmake/platforms/
- A7.toolchain.cmake
- A8.toolchain.cmake
- A9.toolchain.cmake
- ARM9.toolchain.cmake


### toolchain.cmake
toolchain 脚本使用cmake格式，大概内容如下：

``` makefile
SET(CMAKE_SYSTEM_NAME Linux)
SET(CMAKE_CROSSCOMPILING TRUE)

# SET(CMAKE_C_COMPILER /opt/zlg/m1808-sdk-v1.3.1-ga/host/bin/aarch64-linux-gnu-gcc)
# SET(CMAKE_CXX_COMPILER /opt/zlg/m1808-sdk-v1.3.1-ga/host/bin/aarch64-linux-gnu-g++)

SET(CMAKE_C_COMPILER /opt/zlg/m1808-sdk-v1.3.1-ga/host/bin/aarch64-linux-gnu-gcc)
SET(CMAKE_CXX_COMPILER /opt/zlg/m1808-sdk-v1.3.1-ga/host/bin/aarch64-linux-gnu-g++)

# SET(CMAKE_FIND_ROOT_PATH  /opt/zlg/m1808-sdk-v1.3.1-ga/host/aarch64-buildroot-linux-gnu/sysroot)
# SET(CMAKE_C_FLAGS_INIT "--sysroot=${CMAKE_FIND_ROOT_PATH}")
# SET(CMAKE_CXX_FLAGS_INIT "--sysroot=${CMAKE_FIND_ROOT_PATH}")

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)
```


### usage

cmake中使用toolchain:

```
cmake -DCMAKE_TOOLCHAIN_FILE=../CMake/A7.toolchain.cmake  ..
```

## misc
### toolchain diff
```
# SET(CMAKE_FIND_ROOT_PATH  /opt/A9/sysroots/cortexa9hf-vfp-neon-poky-linux-gnueabi)
set(CMAKE_BUILD_TYPE "Release")
```