# Lua热重载

[![zhutaorun](https://pica.zhimg.com/v2-a925223861f95d52dd673be6b79870c6_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/zhutaorun)

[zhutaorun](https://www.zhihu.com/people/zhutaorun)

游戏研发猿/Dota2/被催婚中



7 人赞同了该文章



> 之前项目用Lua的模块很少，确实没关注是否在客户端部分实现热重载。因为项目的服务器开发是C++和Lua的组合，在配合处理开发的时候，服务器脚本实现热重载。在客户端使用Lua的模块越来越多，也有人更多的同事开始用Lua开发。为了提高开发效率，觉得还是可以花点时间在客户端实现下Lua热重载。

Lua的特点：基于寄存器的虚拟机，简洁的语法，高效的编译执行，容易嵌入的特性。Lua在国内互联网技术上的应用也占领不少市场，redis，openresty, skynet等等都能看到Lua忙碌的身影。

### 一、原理

函数requier在表中package.loaded中检查模块是否已被加载。 最简单粗暴的热更新就是将package.loaded[modelname]的值置为nil，强制重新加载：

```lua
function reload_module_obsolete(module_name)
    package.loaded[module_name] = nil
    require(module_name)
end
```

这样就能解决当个界面对应的Lua文件的热重载，因为有Lua对于命名有规则要求。在界面输入对面界面的Lua名称，根据配置表读取到对应的路径。当重载的界面在打开的情况下，需要关闭在重新打开才能更新对应的变化内容(是基类的实例化，对应引用没办法更新)。

实现范围仅限于单个界面的Lua脚本更新，要在GM输入对应的修改Lua脚本名称。

### 二、迭代后

当一些常量枚举的表更新值后，希望不要让Unity,重新Play。因为在这些表在_G（Lua的全局变量表）中，就可以根据对应的表名实现重载。

```lua
--这样做虽然能完成热更，但问题是已经引用了该模块的地方不会得到更新， 因此我们需要将引用该模块的地方的值也做对应的更新。
function ReloadUtil.Reload_Module(module_name)
    local old_module = _G[module_name]

    package.loaded[module_name] = nil
    require (module_name)

    local new_module = _G[module_name]
    for k, v in pairs(new_module) do
        old_module[k] = v
    end

    package.loaded[module_name] = old_module
end
```

对于表中的K的V进行更新，使用于修改和新增，删除的情况，一般来说基本没有，都不使用了，这个值就不进行更新了。

这个时候根据文件夹和文件名实现了自动热重载，但是还有一些单例的脚本没办法更新。使用仍然有限制使用的范围。

如何自动监听文件修改，我会单独写一篇来解释。一个是C#基于FileSystemWatcher,一个是Unity的AssetPostprocessor

### 三、重启Lua虚拟机更新

这样的处理方式有点简单粗暴，但是没啥问题。这个方案之前也构思过。因为Lua有一些数据要做持久的缓存，就难以这个处理。为了处理在5点后开启的活动，同时减少服务器上线的推送压力。客户端根据配置主动请求相关的数据，这样对于数据请求的接口有要求和规范了。

目前这个版本调整完以后，在客户端加入根据的修改的文件类型判断，自动重启Lua虚拟机的方式，开发效率会更高一点。

### 四、建立一张新的全局表与旧的_G作比较

想了不适合当前项目，项目以C#主,少量的Lua。也探究了其中的原理。

```lua
local Old = package.loaded[PathFile]  
local func, err = loadfile(PathFile)  
--先缓存原来的旧内容  
local OldCache = {}  
for k,v in pairs(Old) do  
     OldCache[k] = v  
     Old[k] = nil  
end  
--使用原来的module作为fenv，可以保证之前的引用可以更新到  
setfenv(func, Old)()
```

setenv是Lua 5.1中可以改变作用域的函数，或者可以给函数的执行设置一个环境表，如果不调用setenv的话，一段lua chunk的环境表就是_G，即Lua State的全局表，print,pair,require这些函数实际上都存储在全局表里面。那么这个setenv有什么用呢？我们知道loadstring一段lua代码以后，会经过语法解析返回一个Proto，Lua加载任何代码chunk或function都会返回一个Proto，执行这个Proto就可以初始化我们的lua chunk。为了让更新的时候不污染_G的数据，我们可以给这个Proto设置一个空的环境表。同时，我们可以保留旧的环境表来保证之前的引用有效。

```lua
for name,value in pairs(env) do
    local g_value = _G[name]
    if type(g_value) ~= type(value) then
        _G[name] = value
    elseif type(value) == 'function' then
        update_func(value, g_value, name, 'G'..'  ')
        _G[name] = value
    elseif type(value) == 'table' then
        update_table(value, g_value, name, 'G'..'  ')
    end
end
```

旧环境表里的数据和代码做处理，主要是注意处理function和模拟的class的更新细节

```lua
function update_func(env_f, g_f, name, deep)
    --取得原值所有的upvalue，保存起来
    local old_upvalue_map = {}
    for i = 1, math.huge do
        local name, value = debug.getupvalue(g_f, i)
        if not name then break end
        old_upvalue_map[name] = value
    end
    --遍历所有新的upvalue，根据名字和原值对比，如果原值不存在则进行跳过，如果为其它值则进行遍历env类似的步骤
    for i = 1, math.huge do
        local name, value = debug.getupvalue(env_f, i)
        if not name then break end
        local old_value = old_upvalue_map[name]
        if old_value then
            if type(old_value) ~= type(value) then
                debug.setupvalue(env_f, i, old_value)
            elseif type(old_value) == 'function' then
                update_func(value, old_value, name, deep..'  '..name..'  ')
            elseif type(old_value) == 'table' then
                update_table(value, old_value, name, deep..'  '..name..'  ')
                debug.setupvalue(env_f, i, old_value)
            else
                debug.setupvalue(env_f, i, old_value)
            end
        end
    end
end
```

如果当前值为table，我们遍历table值进行对比

```lua
local protection = {
    setmetatable = true,
    pairs = true,
    ipairs = true,
    next = true,
    require = true,
    _ENV = true,
}
--防止重复的table替换，造成死循环
local visited_sig = {}
function update_table(env_t, g_t, name, deep)
    --对某些关键函数不进行比对
    if protection[env_t] or protection[g_t] then return end
    --如果原值与当前值内存一致，值一样不进行对比
    if env_t == g_t then return end
    local signature = tostring(g_t)..tostring(env_t)
    if visited_sig[signature] then return end
    visited_sig[signature] = true
    --遍历对比值，如进行遍历env类似的步骤
    for name, value in pairs(env_t) do
        local old_value = g_t[name]
        if type(value) == type(old_value) then
            if type(value) == 'function' then
                update_func(value, old_value, name, deep..'  '..name..'  ')
                g_t[name] = value
            elseif type(value) == 'table' then
                update_table(value, old_value, name, deep..'  '..name..'  ')
            end
        else
            g_t[name] = value
        end
    end
    --遍历table的元表，进行对比
    local old_meta = debug.getmetatable(g_t)
    local new_meta = debug.getmetatable(env_t)
    if type(old_meta) == 'table' and type(new_meta) == 'table' then
        update_table(new_meta, old_meta, name..'s Meta', deep..'  '..name..'s Meta'..'  ' )
    end
end
```

模拟的class的更新细节

```lua
local function OnReload(self)
    print('call onReload from: ',self.__cname)
    if self.__ctype == ClassType.class then
        print("this is a class not a instance")
        for k,v in pairs(self.instances) do
            print("call instance reload: ",k)
            if v.OnReload ~= nil then
                v:OnReload()
            end
        end
    else
        if self.__ctype == ClassType.instance then
            print("this is a instance")
                oldFunc = self.oldFunc
        end
    end
end
```

[详细代码](https://link.zhihu.com/?target=https%3A//github.com/tickbh/td_rlua/wiki/Lua-%25E7%2583%25AD%25E6%259B%25B4%25E6%2596%25B0%25E5%25B0%258F%25E7%25BB%2593)

### 五、管理每一个Lua文件的加载

为了每个要重载的Lua文件，以model为名放到changeList的表中。

在 reload 前建立一个沙盒。让 reload 过程不要溢出沙盒。一旦有这种情况至少调用者可以知道。

约束比较简单，就是只更新函数，不更新除函数以外的东西

可能会有的问题： 1. 不用 upvaluejoin 是不能将 upvalue 关联对的。只有 upvalue 是 table 且运行时不会修改 upvalue 才可以正确运行。 2. 遍历 VM 不周全。没有遍历 userdata ，没有遍历 thread 调用栈。针对 5.1 来说，还需要遍历函数的 env 。 3. 简单遍历 module table 是不能保证找到所有 module 相关的函数的。

[详细代码](https://link.zhihu.com/?target=https%3A//github.com/asqbtcupid/lua_hotupdate)

[作者相应的博客文章【Lua热更新原理】](https://link.zhihu.com/?target=http%3A//asqbtcupid.github.io/luahotupdate1-require/)

### 六、关于热更新涉及的点

- upvalue
- getupvalue (f, up)， setupvalue (f, up, value)
- _G和debug.getregistry
- getfenv(object) ，setfenv（function,_ENV）

### 附

参考：

1.[cloudwu/luareload](https://link.zhihu.com/?target=https%3A//github.com/cloudwu/luareload)

2.[如何让 lua 做尽量正确的热更新](https://link.zhihu.com/?target=https%3A//blog.codingnow.com/2016/11/lua_update.html)

3.[【reload script】lua客户端脚本热更](https://link.zhihu.com/?target=https%3A//blog.csdn.net/u013040497/article/details/86424000)

4.[Lua脚本热更新](https://link.zhihu.com/?target=https%3A//www.jianshu.com/p/015c41bfb7d0)

5.[Lua-热更新小结](https://link.zhihu.com/?target=https%3A//github.com/tickbh/td_rlua/wiki/Lua-%25E7%2583%25AD%25E6%259B%25B4%25E6%2596%25B0%25E5%25B0%258F%25E7%25BB%2593)



**本文标题:**[Lua热重载](https://link.zhihu.com/?target=https%3A//zhutaorun.win/2020/12/13/Lua%25E7%2583%25AD%25E9%2587%258D%25E8%25BD%25BD/)

**文章作者:**[zhutaorun](https://link.zhihu.com/?target=https%3A//zhutaorun.win/)

**发布时间:**2020-12-13, 15:01:34

**最后更新:**2020-12-13, 15:11:17

**原始链接:**[http://zhutaorun.win/2020/12/13/Lua热重载/](https://link.zhihu.com/?target=https%3A//zhutaorun.win/2020/12/13/Lua%25E7%2583%25AD%25E9%2587%258D%25E8%25BD%25BD/)

**许可协议:** ["署名-非商用-相同方式共享 4.0"](https://link.zhihu.com/?target=http%3A//creativecommons.org/licenses/by-nc-sa/4.0/) 转载请保留原文链接及作者。[Lua热重载](https://link.zhihu.com/?target=http%3A//zhutaorun.win/2020/12/13/Lua%25E7%2583%25AD%25E9%2587%258D%25E8%25BD%25BD/)**许可协议:** ["署名-非商用-相同方式共享 4.0"](https://link.zhihu.com/?target=http%3A//creativecommons.org/licenses/by-nc-sa/4.0/) 转载请保留原文链接及作者。

发布于 2020-12-13 15:21

服务端开发

C++