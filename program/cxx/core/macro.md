# macro

## 条件编译语句

* 连续if-else判断
* define
`#if`, `#ifdef`,`#ifndef` #undef

``` c++
#if 1
;
#elif A==2
;
#else

#endif

#ifdef ABC
;
#elif defined(ABC)

#else

#endif

#if defined(macro1) || (!defined(macro2) && defined(macro3))
...
#else
...
#endif

```