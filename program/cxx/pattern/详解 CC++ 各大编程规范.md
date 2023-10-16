# 详解 C/C++ 各大编程规范

[![快乐代码](https://pic1.zhimg.com/v2-18f6e5ed745f3879ed4d375162277637_l.jpg?source=172ae18b)](https://www.zhihu.com/people/pai-xie-si-er-cha)

[快乐代码](https://www.zhihu.com/people/pai-xie-si-er-cha)

安全！是高级享受！

52 人赞同了该文章

伴随 C/C++ 语言高度的灵活性和广泛的适用性，产生了面向语言、行业、企业等不同适用范围的编程规范，各有特点和侧重，本文分享如下具有典型意义的规范体系：

## Google C++ Style Guide

[Google C++ Style Guide](https://google.github.io/styleguide/cppguide.html)，[[中文版\]](https://github.com/zh-google-styleguide/zh-google-styleguide)，简称 GSG，谷歌的 C++ 编程规范，在国内有较大影响力，是企业级规范，对代码的具体样式有细致的规定，可直接采用。

由于历史原因，GSG 较为保守，通过抑制语言特性以达到规避风险的目的。在早期尚未形成所谓“现代”编程思想的时候，此规范就已经面世并发挥作用了，其中的某些观点可能与官方不符，比如 C++ 创始人曾一度认为用常数 0 表示空指针比用 NULL 更好，而 GSG 则认为用 NULL 更好，但历史表明 GSG 的观点是正确的，C++11 引入了专属符号 nullptr 以表示空指针的值。

GSG 是实践经验的总结，也在不断发展，目前已适应 C++17，对提升代码可维护性有很高的参考价值。

## C++ Core Guidelines

[C++ Core Guidelines](https://link.zhihu.com/?target=http%3A//isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines)，[[中文版\]](https://github.com/lynnboy/CppCoreGuidelines-zh-CN)，简称 CCG，是 C++ 创始人对 C++ 代码编写的宏观指导，属于语言级规范体系，全面地阐述了现代 C++ 编程思想，以规则条款的形式明确地指出哪些是要避免的，哪些是值得提倡的，具有权威性，适合开发者学习。

由于其篇幅宏大细节繁多，可在相应代码审计工具的支持下作为企业的编程规范和审计依据。

## SEI CERT Coding Standards

[SEI CERT Coding Standards](https://wiki.sei.cmu.edu/confluence/display/seccode)，简称 CERT，是 CMU（Carnegie Mellon University）软件工程研究所（SEI）发布的 C/C++ 编码规范，专注于安全问题，适合与其他规范配合使用。

CERT 提供了较为全面的安全措施，如敏感信息的保护、注入或劫持的预防等等是值得所有开发人员学习的。

## MISRA C/C++

[MISRA C/C++](https://www.misra.org.uk/)，是由英国汽车产业软件可靠性协会（Motor Industry Software Reliability Association）提出的 C/C++ 语言开发标准，在嵌入式开发领域有较高认可度，是行业级规范，企业可直接采用，但需购买相关文档或技术支持。

MISRA 调强代码静态结构的合规性，规则较为严格，梳理了标准中“未定义”、“未声明”、“实现定义”的情况，总结可导致不良后果的代码形式并以此为规范依据，当前发行版本遵循 C99 和 C++03 标准。

## High Integrity C++ Coding Standard

[High Integrity C++ Coding Standard](https://www.perforce.com/resources/qac/high-integrity-cpp-coding-standard)，历史悠久的 C/C++ 规范体系，现归属于 Perforce Software, Inc.，提供独特而有效的方法提升代码质量并规避风险，被多种知名规范参考引用，而且还提供合规性审计软件，但并不侧重于安全问题，适合与 SEI CERT 等安全类规范配合使用。

## 华为 C&C++ 语言安全编程规范

华为 C&C++ 语言安全编程规范，阐述了编程时必须面对的最关键的 8 类问题（资源、安全、敏感信息等），适合企业直接采用。

此规范较为简练便于记忆，所以适合在 Code Review 时人工对代码展开相关检查和讨论，由于不是以网站形式发布的，这里就不提供链接了，可自行搜索相关文档。

## 腾讯代码安全指南

[腾讯代码安全指南](https://github.com/Tencent/secguide)，直接面向各种库或 API 的使用，阐明存在的安全问题和解决方法，有较高的实用价值，除了 C 和 C++ 语言，还提供对 Java、Javascript、Go、Python 等语言的编程指导。

## 360 安全规则集合

[360 安全规则集合](https://github.com/Qihoo360/safe-rules)，融汇多种编程理念，提供适用于不同场景的规则供用户选取，适用于桌面、服务端及嵌入式软件系统，也属于语言级规范体系。

安全规则集合侧重违规代码的量化界定，严格遵循 C11 和 C++11 标准，并兼顾 C18、C++17 以及历史标准，可为不同方向的开发团队提供灵活而统一的规范指导。

发布于 2022-03-17 15:37

[C++](https://www.zhihu.com/topic/19584970)

[编程规范](https://www.zhihu.com/topic/19653375)

[编程语言](https://www.zhihu.com/topic/19552826)