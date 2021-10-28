# Android硬件抽象层HAL总结

[诺远](https://www.jianshu.com/u/7c9106dee801)关注

0.4372016.04.06 17:36:39字数 3,016阅读 17,935

## Android HAL概述

Android HAL(Hardware Abstract Layer)硬件抽象层，从字面意思可以看出是对硬件设备的抽象和封装，为Android在不同硬件设备提供统一的访问接口。HAL处于Android framework和Linux kernel driver之间，HAL存在的意义有以下2个方面：

- HAL屏蔽了不同硬件设备的差异，为Android提供了统一的访问硬件设备的接口。不同的硬件厂商遵循HAL标准来实现自己的硬件控制逻辑，但开发者不必关心不同硬件设备的差异，只需要按照HAL提供的标准接口访问硬件就可以了。
- HAL层帮助硬件厂商隐藏了设备相关模块的核心细节。硬件厂商处于利益考虑，不希望公开硬件设备相关的实现细节；有了HAL层之后，他们可以把一些核心的算法之类的东西的实现放在HAL层，而HAL层位于用户空间，不属于linux内核，和android源码一样遵循的是Apache license协议，这个是可以开源或者不开的。

搞清楚了HAL存在的作用，就可以对其框架做个简单的总结。这里从以下3个方面来简单分析下HAL架构，以备后忘。

1. 分析HAL的2个核心数据结构：hw_module_t 和 hw_device_t；
2. 描述HAL是如何查询和加载设备动态共享库的；
3. 以GPS为例，简单分析上层是如何使用HAL来访问硬件设备的。
   以Android 6.0 源码为基础，对HAL框架进行分析。

------

### hw_module_t和hw_device_t

Android HAL将各类硬件设备抽象为硬件模块，HAL使用**hw_module_t**结构体描述一类硬件抽象模块。每个硬件抽象模块都对应一个动态链接库，一般是由厂商提供的，这个动态链接库必须尊重HAL的命名规范才能被HAL加载到，我们后面会看到。
每一类硬件抽象模块又包含多个独立的硬件设备，HAL使用**hw_device_t**结构体描述硬件模块中的独立硬件设备。
因此，hw_module_t和hw_device_t是HAL中的核心数据结构，这2个结构体代表了HAL对硬件设备的抽象逻辑。我们第一步先来分析下这2个核心数据结构。

**hw_module_t**定义在/[hardware](http://androidxref.com/6.0.0_r1/xref/hardware/)/[libhardware](http://androidxref.com/6.0.0_r1/xref/hardware/libhardware/)/[include](http://androidxref.com/6.0.0_r1/xref/hardware/libhardware/include/)/[hardware](http://androidxref.com/6.0.0_r1/xref/hardware/libhardware/include/hardware/)/[hardware.h](http://androidxref.com/6.0.0_r1/xref/hardware/libhardware/include/hardware/hardware.h)文件中：

```dart
/**
 * Every hardware module must have a data structure named HAL_MODULE_INFO_SYM
 * and the fields of this data structure must begin with hw_module_t
 * followed by module specific information.
 */
typedef struct hw_module_t {
    /** tag must be initialized to HARDWARE_MODULE_TAG */
    uint32_t tag;

    /**
     * The API version of the implemented module. The module owner is
     * responsible for updating the version when a module interface has
     * changed.
     *
     * The derived modules such as gralloc and audio own and manage this field.
     * The module user must interpret the version field to decide whether or
     * not to inter-operate with the supplied module implementation.
     * For example, SurfaceFlinger is responsible for making sure that
     * it knows how to manage different versions of the gralloc-module API,
     * and AudioFlinger must know how to do the same for audio-module API.
     *
     * The module API version should include a major and a minor component.
     * For example, version 1.0 could be represented as 0x0100. This format
     * implies that versions 0x0100-0x01ff are all API-compatible.
     *
     * In the future, libhardware will expose a hw_get_module_version()
     * (or equivalent) function that will take minimum/maximum supported
     * versions as arguments and would be able to reject modules with
     * versions outside of the supplied range.
     */
    uint16_t module_api_version;
#define version_major module_api_version
    /**
     * version_major/version_minor defines are supplied here for temporary
     * source code compatibility. They will be removed in the next version.
     * ALL clients must convert to the new version format.
     */

    /**
     * The API version of the HAL module interface. This is meant to
     * version the hw_module_t, hw_module_methods_t, and hw_device_t
     * structures and definitions.
     *
     * The HAL interface owns this field. Module users/implementations
     * must NOT rely on this value for version information.
     *
     * Presently, 0 is the only valid value.
     */
    uint16_t hal_api_version;
#define version_minor hal_api_version

    /** Identifier of module */
    const char *id;

    /** Name of this module */
    const char *name;

    /** Author/owner/implementor of the module */
    const char *author;

    /** Modules methods */
    struct hw_module_methods_t* methods;

    /** module's dso */
    void* dso;

#ifdef __LP64__
    uint64_t reserved[32-7];
#else
    /** padding to 128 bytes, reserved for future use */
    uint32_t reserved[32-7];
#endif

} hw_module_t;
```

- 注释里面规定，每个硬件模块必须包含一个名字为*HAL_MODULE_INFO_SYM*的结构体；这个结构体的第一个元素必须为hw_module_t，然后后面可以增加模块相关的其他信息。**这里可以理解为是一种继承关系，相当于应硬件模块的HAL_MODULE_INFO_SYM结构体，继承了hw_module_t，只不过是C语言中没有继承的概念，是通过在结构体中包含的方式间接实现的。**
  HAL_MODULE_INFO_SYM值定义同样在hardware.h中：

```cpp
/**
 * Name of the hal_module_info
 */
#define HAL_MODULE_INFO_SYM         HMI

/**
 * Name of the hal_module_info as a string
 */
#define HAL_MODULE_INFO_SYM_AS_STR  "HMI"
```

- tag: 必须被初始化HARDWARE_MODULE_TAG常量，其定义在hardware.h中：

```cpp
/*
 * Value for the hw_module_t.tag field
 */

#define MAKE_TAG_CONSTANT(A,B,C,D) (((A) << 24) | ((B) << 16) | ((C) << 8) | (D))

#define HARDWARE_MODULE_TAG MAKE_TAG_CONSTANT('H', 'W', 'M', 'T')
#define HARDWARE_DEVICE_TAG MAKE_TAG_CONSTANT('H', 'W', 'D', 'T')
```

- version相关信息，不多说
- 紧跟着是模块id，name，author,看名字就知道意思了。
- dso：用来保存加载硬件抽象模块后得到的句柄值，前面提到每一个硬件抽象模块都对应一个动态链接库，硬件抽象模块的加载过程实际是使用**dlopen**函数打开对应的动态链接库文件获得这个句柄；使用**dlclose**函数进行硬件抽象模块的卸载是需要用到这个句柄，因此需要保存起来。
- struct hw_module_methods_t* methods：看名字应该是操作该硬件模块的方法。hw_module_methods_t定义在hardware.h，如下：

```cpp
typedef struct hw_module_methods_t {
    /** Open a specific device */
    int (*open)(const struct hw_module_t* module, const char* id,
            struct hw_device_t** device);

} hw_module_methods_t;
```

我们看到，hw_module_methods_t只有一个函数指针**open**，根据参数可以推断出open是用来打开硬件模块获取模块中的硬件设备。由于一个硬件抽象模块中可能包含多个设备，因此需要根据传入的设备id来获取相应的硬件设备he_device_t。所以这里的device就表示一个已经打开的硬件设备。

下面来看看hw_device_t结构体的定义：hardware.h

```cpp
/**
 * Every device data structure must begin with hw_device_t
 * followed by module specific public methods and attributes.
 */
typedef struct hw_device_t {
    /** tag must be initialized to HARDWARE_DEVICE_TAG */
    uint32_t tag;

    /**
     * Version of the module-specific device API. This value is used by
     * the derived-module user to manage different device implementations.
     *
     * The module user is responsible for checking the module_api_version
     * and device version fields to ensure that the user is capable of
     * communicating with the specific module implementation.
     *
     * One module can support multiple devices with different versions. This
     * can be useful when a device interface changes in an incompatible way
     * but it is still necessary to support older implementations at the same
     * time. One such example is the Camera 2.0 API.
     *
     * This field is interpreted by the module user and is ignored by the
     * HAL interface itself.
     */
    uint32_t version;

    /** reference to the module this device belongs to */
    struct hw_module_t* module;

    /** padding reserved for future use */
#ifdef __LP64__
    uint64_t reserved[12];
#else
    uint32_t reserved[12];
#endif

    /** Close this device */
    int (*close)(struct hw_device_t* device);

} hw_device_t;
```

- HAL规定每个硬件设备都必须定义一个硬件设备描述结构体，该结构体必须以hw_device_t作为第一个成员变量，后跟设备相关的公开函数和属性。
- tag：初始化为常量HARDWARE_DEVICE_TAG
- module：表示该硬件设备归属于哪一个硬件抽象模块。
- close：函数指针，用来关闭硬件设备。

到此，HAL的2个核心数据结构体就分析完了；硬件厂商必须遵循HAL规范和命名，实现这2个结构体：抽象硬件模块结构体和抽象硬件设备结构体；并且提供open函数来获取hw_device_t。下面我来看HAL到底是怎样获取硬件模块和硬件设备的，是如何加载和解析对应的动态共享库的。

------

## HAL模块的加载

我们知道每个硬件抽象模块都对应一个动态链接库，这个是厂商提供的，存放在默认的路径下；HAL在需要的时候会去匹配和加载动态链接库。那么HAL是如何找到某个硬件模块对应的正确的共享库呢？

首先，每个模块对应的动态链接库的名字是遵循HAL的命名规范的。举例说明，以GPS模块为例，典型的共享库名字如下：

> **gps.mt6753.so**
> <MODULE_ID>.variant.so

1. 
2. 

- ro.hardware
- ro.product.board
- ro.board.platform
- ro.arch

硬件抽象模块的动态链接库文件名命名规范定义在：/[hardware](http://androidxref.com/6.0.0_r1/xref/hardware/)/[libhardware](http://androidxref.com/6.0.0_r1/xref/hardware/libhardware/)/[hardware.c](http://androidxref.com/6.0.0_r1/xref/hardware/libhardware/hardware.c)：

```dart
/**
 * There are a set of variant filename for modules. The form of the filename
 * is "<MODULE_ID>.variant.so" so for the led module the Dream variants
 * of base "ro.product.board", "ro.board.platform" and "ro.arch" would be:
 *
 * led.trout.so
 * led.msm7k.so
 * led.ARMV6.so
 * led.default.so
 */

static const char *variant_keys[] = {
    "ro.hardware",  /* This goes first so that it can pick up a different
                       file on the emulator. */
    "ro.product.board",
    "ro.board.platform",
    "ro.arch"
};
//后面会用到
static const int HAL_VARIANT_KEYS_COUNT =
    (sizeof(variant_keys)/sizeof(variant_keys[0]));
```

HAL会按照variant_keys[]定义的属性名称的顺序逐一来读取属性值，若值存在，则作为variant的值加载对应的动态链接库。如果没有读取到任何属性值，则使用`<MODULE_ID>.default.so` 作为默认的动态链接库文件名来加载硬件模块。

有了模块的文件名字规范，那么共享库的存放路径也是有规范的。HAL规定了2个硬件模块动态共享库的存放路径，定义在/[hardware](http://androidxref.com/6.0.0_r1/xref/hardware/)/[libhardware](http://androidxref.com/6.0.0_r1/xref/hardware/libhardware/)/[hardware.c](http://androidxref.com/6.0.0_r1/xref/hardware/libhardware/hardware.c)：

```cpp
/** Base path of the hal modules */
#if defined(__LP64__)
#define HAL_LIBRARY_PATH1 "/system/lib64/hw"
#define HAL_LIBRARY_PATH2 "/vendor/lib64/hw"
#else
#define HAL_LIBRARY_PATH1 "/system/lib/hw"
#define HAL_LIBRARY_PATH2 "/vendor/lib/hw"
#endif
```

也就是说硬件模块的共享库必须放在*/system/lib/hw 或者 /vendor/lib/hw* 这2个路径下的其中一个。HAL在加载所需的共享库的时候，会先检查HAL_LIBRARY_PATH2路径下面是否存在目标库；如果没有，继续检查HAL_LIBRARY_PATH1路径下面是否存在。具体实现在函数**hw_module_exists**, /[hardware](http://androidxref.com/6.0.0_r1/xref/hardware/)/[libhardware](http://androidxref.com/6.0.0_r1/xref/hardware/libhardware/)/[hardware.c](http://androidxref.com/6.0.0_r1/xref/hardware/libhardware/hardware.c):

```cpp
/*
 * Check if a HAL with given name and subname exists, if so return 0, otherwise
 * otherwise return negative.  On success path will contain the path to the HAL.
 */
static int hw_module_exists(char *path, size_t path_len, const char *name,
                            const char *subname)
{
    //检查/vendor/lib/hw路径下是否存在目标模块
    snprintf(path, path_len, "%s/%s.%s.so",
             HAL_LIBRARY_PATH2, name, subname);
    if (access(path, R_OK) == 0)
        return 0;
    //检查/system/lib/hw路径下是否存在目标模块
    snprintf(path, path_len, "%s/%s.%s.so",
             HAL_LIBRARY_PATH1, name, subname);
    if (access(path, R_OK) == 0)
        return 0;

    return -ENOENT;
}
```

- name：其实对应上面提到的MODULE_ID
- subname: 对应从上面提到的属性值variant

现在我们知道了HAL是如何命名和存放模块共享库的，以及HAL基于这种机制来检查目标模块库是否存在的方法。下面来看上传framework打开和加载模块共享库的具体实现过程。

------

上传framework和应用打开HAL库的入口函数为**hw_get_module**,定义如下[hardware](http://androidxref.com/6.0.0_r1/xref/hardware/)/[libhardware](http://androidxref.com/6.0.0_r1/xref/hardware/libhardware/)/[include](http://androidxref.com/6.0.0_r1/xref/hardware/libhardware/include/)/[hardware](http://androidxref.com/6.0.0_r1/xref/hardware/libhardware/include/hardware/)/[hardware.h](http://androidxref.com/6.0.0_r1/xref/hardware/libhardware/include/hardware/hardware.h)：

```cpp
/**
 * Get the module info associated with a module by id.
 *
 * @return: 0 == success, <0 == error and *module == NULL
 */
int hw_get_module(const char *id, const struct hw_module_t **module);
```

- 传入目标模块的唯一id，得到表示该模块的hw_module_t结构体指针

具体实现在文件[hardware](http://androidxref.com/6.0.0_r1/xref/hardware/)/[libhardware](http://androidxref.com/6.0.0_r1/xref/hardware/libhardware/)/[hardware.c](http://androidxref.com/6.0.0_r1/xref/hardware/libhardware/hardware.c)，下面我们具体来分析。

```cpp
int hw_get_module(const char *id, const struct hw_module_t **module)
{
    return hw_get_module_by_class(id, NULL, module);
}
```

hw_get_module实际上调用了hw_get_module_by_class来执行实际的工作。

```cpp
int hw_get_module_by_class(const char *class_id, const char *inst,
                           const struct hw_module_t **module)
{
    int i = 0;
    char prop[PATH_MAX] = {0};
    char path[PATH_MAX] = {0};
    char name[PATH_MAX] = {0};
    char prop_name[PATH_MAX] = {0};

    //根据id生成module name，这里inst为NULL
    if (inst)
        snprintf(name, PATH_MAX, "%s.%s", class_id, inst);
    else
        strlcpy(name, class_id, PATH_MAX);

    /*
     * Here we rely on the fact that calling dlopen multiple times on
     * the same .so will simply increment a refcount (and not load
     * a new copy of the library).
     * We also assume that dlopen() is thread-safe.
     */

    /* First try a property specific to the class and possibly instance */
    //首先查询特定的属性名称来获取variant值
    snprintf(prop_name, sizeof(prop_name), "ro.hardware.%s", name);
    if (property_get(prop_name, prop, NULL) > 0) {
        //检查目标模块共享库是否存在
        if (hw_module_exists(path, sizeof(path), name, prop) == 0) {
            goto found; //存在，找到了
        }
    }

    /* Loop through the configuration variants looking for a module */
    //逐一查询variant_keys数组定义的属性名称
    for (i=0 ; i<HAL_VARIANT_KEYS_COUNT; i++) {
        if (property_get(variant_keys[i], prop, NULL) == 0) {
            continue;
        }
        //检查目标模块共享库是否存在
        if (hw_module_exists(path, sizeof(path), name, prop) == 0) {
            goto found;
        }
    }
    //没有找到，尝试默认variant名称为default的共享库
    /* Nothing found, try the default */
    if (hw_module_exists(path, sizeof(path), name, "default") == 0) {
        goto found;
    }

    return -ENOENT;

found:
    /* load the module, if this fails, we're doomed, and we should not try
     * to load a different variant. */
    return load(class_id, path, module); //执行加载和解析共享库的工作
}
```

1. 首先根据class_id生成module name，这里就是hw_get_module函数传进来的id；
2. 根据属性名称“ro.hardware.<id>”获取属性值，如果存在，则作为variant值调用前面提到的hw_module_exits检查目标是否存在。如果存在，执行load。
3. 如果不存在，则遍历variant_keys数组中定义的属性名称来获取属性值，得到目标模块库名字，检查其是否存在；
4. 如果根据属性值都没有找到模块共享库，则尝试检查default的库是否存在；如果仍然不存在，返回错误。
5. 如果上述任何一次尝试找到了目标共享库，path就是目标共享库的文件路径，调用load执行真正的加载库的工作。

下面来看load函数：

```objectivec
/**
 * Load the file defined by the variant and if successful
 * return the dlopen handle and the hmi.
 * @return 0 = success, !0 = failure.
 */
static int load(const char *id,
        const char *path,
        const struct hw_module_t **pHmi)
{
    int status = -EINVAL;
    void *handle = NULL;
    struct hw_module_t *hmi = NULL;

    /*
     * load the symbols resolving undefined symbols before
     * dlopen returns. Since RTLD_GLOBAL is not or'd in with
     * RTLD_NOW the external symbols will not be global
     */
    //使用dlopen打开path定义的目标共享库，得到库文件的句柄handle
    handle = dlopen(path, RTLD_NOW);
    if (handle == NULL) {
        //出错，通过dlerror获取错误信息
        char const *err_str = dlerror();
        ALOGE("load: module=%s\n%s", path, err_str?err_str:"unknown");
        status = -EINVAL;
        goto done;
    }

    /* Get the address of the struct hal_module_info. */
    const char *sym = HAL_MODULE_INFO_SYM_AS_STR; //"HMI"
    //使用dlsym找到符号为“HMI”的地址，这里应该是hw_module_t结构体的地址；并且赋给hmi
    hmi = (struct hw_module_t *)dlsym(handle, sym);
    if (hmi == NULL) {
        ALOGE("load: couldn't find symbol %s", sym);
        status = -EINVAL;
        goto done;
    }

    /* Check that the id matches */
    //检查模块id是否匹配
    if (strcmp(id, hmi->id) != 0) {
        ALOGE("load: id=%s != hmi->id=%s", id, hmi->id);
        status = -EINVAL;
        goto done;
    }
    //保存共享库文件的句柄
    hmi->dso = handle;

    /* success */
    status = 0;

    done:
    if (status != 0) {
        hmi = NULL;
        if (handle != NULL) {
            dlclose(handle);
            handle = NULL;
        }
    } else {
        ALOGV("loaded HAL id=%s path=%s hmi=%p handle=%p",
                id, path, *pHmi, handle);
    }
    //返回得到的hw_module_t结构体的指针
    *pHmi = hmi;

    return status;
}
```

- load函数的主要工作时通过dlopen来打开目标模块共享库，打开成功后，使用dlsym来得到符号名字为"HMI"的地址。这里的HMI应该是模块定义的hw_module_t结构体的名字，如此，就得到了模块对应的hw_module_t的指针。

至此，我么终于得到了表示硬件模块的hw_module_t的指针，有了这个指针，就可以对硬件模块进行操作了。HAL是如何查找和加载模块共享库的过程就分析完了，最终还是通过**dlopen和dlsym**拿到了模块的hw_module_t的指针，就可以为所欲为了。

## GPS HAL加载过程

------

前面分析完了HAL的框架和机制，以GPS HAL的加载过程为例把上面的知识串起来。我们从framework层的hw_get_module函数作为入口点，初步拆解分析。
加载GPS HAL的入口函数定义在[frameworks](http://androidxref.com/6.0.0_r1/xref/frameworks/)/[base](http://androidxref.com/6.0.0_r1/xref/frameworks/base/)/[services](http://androidxref.com/6.0.0_r1/xref/frameworks/base/services/)/[core](http://androidxref.com/6.0.0_r1/xref/frameworks/base/services/core/)/[jni](http://androidxref.com/6.0.0_r1/xref/frameworks/base/services/core/jni/)/[com_android_server_location_GpsLocationProvider.cpp](http://androidxref.com/6.0.0_r1/xref/frameworks/base/services/core/jni/com_android_server_location_GpsLocationProvider.cpp)：

```cpp
static void android_location_GpsLocationProvider_class_init_native(JNIEnv* env, jclass clazz) {
// skip unrelate code
    hw_module_t* module;
   //获取GPS模块的hw_module_t指针
    err = hw_get_module(GPS_HARDWARE_MODULE_ID, (hw_module_t const**)&module);
    if (err == 0) {
        hw_device_t* device;
        //调用open函数得到GPS设备的hw_device_t指针
        err = module->methods->open(module, GPS_HARDWARE_MODULE_ID, &device);
        if (err == 0) {
            //指针强转为gps_device_t类型
            gps_device_t* gps_device = (gps_device_t *)device;
            //得到GPS模块的inteface接口，通过sGpsInterface就可以操作GPS设备了
            sGpsInterface = gps_device->get_gps_interface(gps_device);
        }
    }
```

- GPS_HARDWARE_MODULE_ID定义在hardware/libhardware/include/hardware/gps.h中：

```cpp
/**
 * The id of this module
 */
#define GPS_HARDWARE_MODULE_ID "gps"
```

- 调用hw_get_module得到GPS模块的hw_module_t指针，保存在module变量中；我们来看下GPS模块的hw_module_t长得什么样。以hardware/qcom/gps/loc_api/libloc_api_50001/gps.c为例：

```cpp
struct hw_module_t HAL_MODULE_INFO_SYM = {
    .tag = HARDWARE_MODULE_TAG,
    .module_api_version = 1,
    .hal_api_version = 0,
    .id = GPS_HARDWARE_MODULE_ID,
    .name = "loc_api GPS Module",
    .author = "Qualcomm USA, Inc.",
    .methods = &gps_module_methods, //自定义的函数指针，这里既是获取hw_device_t的入口了
};
```

- 接着调用GPS模块自定义的hw_module_t的methods中的open函数，获取hw_device_t指针。上面的代码中我们看到，GPS模块的hw_module_t的methods成员的值为`gps_module_methods`,其定义如下：

```swift
static struct hw_module_methods_t gps_module_methods = {
    .open = open_gps
};
```

OK，我们来看`open_gps`函数做了什么：

```rust
static int open_gps(const struct hw_module_t* module, char const* name,
        struct hw_device_t** device)
{
    //为gps_device_t分配内存空间
    struct gps_device_t *dev = (struct gps_device_t *) malloc(sizeof(struct gps_device_t));

    if(dev == NULL)
        return -1;

    memset(dev, 0, sizeof(*dev));
    //为gps_device_t的common成员变量赋值
    dev->common.tag = HARDWARE_DEVICE_TAG;
    dev->common.version = 0;
    dev->common.module = (struct hw_module_t*)module;
    //通过下面的函数就能得到GPS模块所有interface
    dev->get_gps_interface = gps__get_gps_interface;
    //将gps_device_t指针强转为hw_device_t指针，赋给device
    *device = (struct hw_device_t*)dev;
    return 0;
}
```

我们看到open_gps创建了gps_device_t结构体，初始化完成后，将其转为hw_device_t。所以`module->methods->open`得到实际上是gps_device_t结构体指针。这里我们可以理解为gps_device_t是hw_device_t的子类，将子类对象转为父类对象返回，是很正常的使用方法。为什么可以这么理解，看一下gps_device_t长得什么样子就明白了。
hardware/libhardware/include/hardware/gps.h：

```rust
struct gps_device_t {
    struct hw_device_t common;

    /**
     * Set the provided lights to the provided values.
     *
     * Returns: 0 on succes, error code on failure.
     */
    const GpsInterface* (*get_gps_interface)(struct gps_device_t* dev);
};
```

啊哈，第一个成员是名为common的hw_device_t类型的变量；所以可以理解为gps_device_t继承了hw_device_t。

- 得到GPS的hw_device_t指针后将其强转回gps_devcie_t指针，然后调用GPS device定义的`get_gps_interface`接口，得到保存GPS 接口的GpsInterface结构体指针。
  在open_gps中，get_gps_interface被赋值为gps__get_gps_interface函数指针，其主要工作就是返回GPS模块的GpsInterface结构体指针。
  GpsInterface定义在hardware/libhardware/include/hardware/gps.h：

```cpp
/** Represents the standard GPS interface. */
typedef struct {
    /** set to sizeof(GpsInterface) */
    size_t          size;
    /**
     * Opens the interface and provides the callback routines
     * to the implementation of this interface.
     */
    int   (*init)( GpsCallbacks* callbacks );

    /** Starts navigating. */
    int   (*start)( void );

    /** Stops navigating. */
    int   (*stop)( void );

    /** Closes the interface. */
    void  (*cleanup)( void );

    /** Injects the current time. */
    int   (*inject_time)(GpsUtcTime time, int64_t timeReference,
                         int uncertainty);

    /** Injects current location from another location provider
     *  (typically cell ID).
     *  latitude and longitude are measured in degrees
     *  expected accuracy is measured in meters
     */
    int  (*inject_location)(double latitude, double longitude, float accuracy);

    /**
     * Specifies that the next call to start will not use the
     * information defined in the flags. GPS_DELETE_ALL is passed for
     * a cold start.
     */
    void  (*delete_aiding_data)(GpsAidingData flags);

    /**
     * min_interval represents the time between fixes in milliseconds.
     * preferred_accuracy represents the requested fix accuracy in meters.
     * preferred_time represents the requested time to first fix in milliseconds.
     *
     * 'mode' parameter should be one of GPS_POSITION_MODE_MS_BASE
     * or GPS_POSITION_MODE_STANDALONE.
     * It is allowed by the platform (and it is recommended) to fallback to
     * GPS_POSITION_MODE_MS_BASE if GPS_POSITION_MODE_MS_ASSISTED is passed in, and
     * GPS_POSITION_MODE_MS_BASED is supported.
     */
    int   (*set_position_mode)(GpsPositionMode mode, GpsPositionRecurrence recurrence,
            uint32_t min_interval, uint32_t preferred_accuracy, uint32_t preferred_time);

    /** Get a pointer to extension information. */
    const void* (*get_extension)(const char* name);
} GpsInterface;
```

- GpsInterface定义了操作GPS模块的基本的标准接口，得到了GpsInterface就可以通过这些接口操作GPS了，终于可以硬件打交道了。某一个具体的GPS模块会将GpsInterface中的接口初始化为其平台相关的具体实现。比如：hardware/qcom/gps/loc_api/libloc_api_50001/loc.cpp

```cpp
// Defines the GpsInterface in gps.h
static const GpsInterface sLocEngInterface =
{
   sizeof(GpsInterface),
   loc_init,
   loc_start,
   loc_stop,
   loc_cleanup,
   loc_inject_time,
   loc_inject_location,
   loc_delete_aiding_data,
   loc_set_position_mode,
   loc_get_extension
};
```

到这里，整个GPS HAL的加载过程就结束了，后面就可以通过GpsInterface操作GPS模块了。

------

本文分析了Android HAL的框架和机制，介绍了它的2个核心数据结构，分析了硬件模块的查询和加载过程；然后以GPS为例走了说明了如何通过HAL得到硬件的接口函数。