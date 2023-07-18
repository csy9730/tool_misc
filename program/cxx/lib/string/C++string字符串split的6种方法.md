# C++string字符串split的6种方法

[![程序喵大人](https://pica.zhimg.com/v2-2f0e242228bbb0445c6f6ce4cd18baba_l.jpg?source=172ae18b)](https://www.zhihu.com/people/chengxumiao)

[程序喵大人](https://www.zhihu.com/people/chengxumiao)![img](https://pic1.zhimg.com/v2-4812630bc27d642f7cafcd6cdeca3d7a.jpg?source=88ceefae)

64 人赞同了该文章

众所周知C++标准库没有提供std::string的split功能，究竟为什么没有提供split方法，我查了很多资料，网上也有很多说法，但是依旧没有找到官方答案。

![img](https://pic3.zhimg.com/80/v2-4e9a4ac72a89bd83a1eb8ddf64f86b56_720w.webp)

既然没有，那我们不如......

按自己的方法实现一个好了。

如果项目库里集成了boost的话，可以直接使用boost的split功能，我这里也列出了6种实现split的方法，分享一下，希望大家能拓宽下思路。

**方法1：stringstream和getline配合使用**

```cpp
std::vector<std::string> stringSplit(const std::string& str, char delim) {
    std::stringstream ss(str);
    std::string item;
    std::vector<std::string> elems;
    while (std::getline(ss, item, delim)) {
        if (!item.empty()) {
            elems.push_back(item);
        }
    }
    return elems;
}
```

**方法2：使用std::string::find**

```cpp
std::vector<std::string> stringSplit(const std::string& str, char delim) {
    std::size_t previous = 0;
    std::size_t current = str.find(delim);
    std::vector<std::string> elems;
    while (current != std::string::npos) {
        if (current > previous) {
            elems.push_back(str.substr(previous, current - previous));
        }
        previous = current + 1;
        current = str.find(delim, previous);
    }
    if (previous != str.size()) {
        elems.push_back(str.substr(previous));
    }
    return elems;
}
```

**方法3：使用std::string::find_first_of**

```cpp
std::vector<std::string> stringSplit(const std::string& str, char delim) {
    std::size_t previous = 0;
    std::size_t current = str.find_first_of(delim);
    std::vector<std::string> elems;
    while (current != std::string::npos) {
        if (current > previous) {
            elems.push_back(str.substr(previous, current - previous));
        }
        previous = current + 1;
        current = str.find_first_of(delim, previous);
    }
    if (previous != str.size()) {
        elems.push_back(str.substr(previous));
    }
    return elems;
}
```

**方法4：使用C语言的strtok方法**

```cpp
std::vector<std::string> stringSplit(const std::string& strIn, char delim) {
    char* str = const_cast<char*>(strIn.c_str());
    std::string s;
    s.append(1, delim);
    std::vector<std::string> elems;
    char* splitted = strtok(str, s.c_str());
    while (splitted != NULL) {
        elems.push_back(std::string(splitted));
        splitted = strtok(NULL, s.c_str());
    }
    return elems;
}
```

**方法5：std::string::find_first_of和std::string::find_first_not_of配合使用**

```cpp
std::vector<std::string> stringSplit(const std::string& str, char delim) {
    std::vector<std::string> elems;
    auto lastPos = str.find_first_not_of(delim, 0);
    auto pos = str.find_first_of(delim, lastPos);
    while (pos != std::string::npos || lastPos != std::string::npos) {
        elems.push_back(str.substr(lastPos, pos - lastPos));
        lastPos = str.find_first_not_of(delim, pos);
        pos = str.find_first_of(delim, lastPos);
    }
    return elems;
}
```

**方法6：使用正则表达式**

```cpp
std::vector<std::string> stringSplit(const std::string& str, char delim) {
    std::string s;
    s.append(1, delim);
    std::regex reg(s);
    std::vector<std::string> elems(std::sregex_token_iterator(str.begin(), str.end(), reg, -1),
                                   std::sregex_token_iterator());
    return elems;
}
```

**参考资料**

> https://www.zhihu.com/question/36642771
> [http://www.martinbroadhurst.com/how-to-split-a-string-in-c.html](https://link.zhihu.com/?target=http%3A//www.martinbroadhurst.com/how-to-split-a-string-in-c.html)

关于C++学习推荐这个资料库，有很多硬核C++文章：

[https://github.com/fightingwangzq/cpp-learninggithub.com/fightingwangzq/cpp-learning](https://link.zhihu.com/?target=https%3A//github.com/fightingwangzq/cpp-learning)



发布于 2021-10-28 21:59

[C++](https://www.zhihu.com/topic/19584970)

[C++ 标准](https://www.zhihu.com/topic/19621071)

[C / C++](https://www.zhihu.com/topic/19601705)