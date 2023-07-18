# [std::thread “terminate called without an active exception”](https://www.cnblogs.com/little-ant/p/3312841.html)

最近在使用std::thread的时候，遇到这样一个问题:

```
std::thread t(func);
```

如果不使用调用t.join()就会遇到 "terminate called whithout an active exception",但是在使用boost:thread的时候却没遇到这个问题，google了一下，找到答案:

The trouble you are encountering is a result of the `stopThread` going out of scope on the stack. The C++ standard has the following to say about this:

> **30.3.1.3** thread destructor [thread.thread.destr]
>
> ~thread();
>
> > If **joinable()** then terminate(), otherwise no effects. [ **Note:** Either implicitly detaching or joining a**joinable()** thread in its destructor could result in difficult to debug correctness (for detach) or performance (for join) bugs encountered only when an exception is raised. Thus the programmer must ensure that the destructor is never executed while the thread is still joinable. — *end note* ]

What this means is that you should not let threads go out of scope without first calling either `join()` or`detatch()`.

The way you describe it, you want the thread to go out of scope without joining so it will continue to run as your application runs. That requires a call to `detach()`. From there, I can only offer a little wisdom...

大意是说，在~thread();前没有调用join()则会遇到问题很难调试，如果不想调用join()等线程结束的话你可以调用detach().这样就不会遇到"terminate called whithout an active exception"

如下:

```cpp
{
    std::thread t(func);
    t.detach();
}
```