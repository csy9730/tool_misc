# C++源码转义技巧 R"()"

[![zhian](https://pica.zhimg.com/bd9de58c33e47830e89956046510c04b_l.jpg?source=172ae18b)](https://www.zhihu.com/people/zhian1990)

[zhian](https://www.zhihu.com/people/zhian1990)![img](https://pica.zhimg.com/v2-4812630bc27d642f7cafcd6cdeca3d7a.jpg?source=88ceefae)

做一个思考者，而不是执行者

5 人赞同了该文章

在我们使用C++/C/Qt等预研开发项目时，通常会遇到需要将字符串进行转义的场景，

例如，用string描述文件地址或者直接用string描述json串。

比如我们描述文件地址时

```cpp
string filePath = "C:\Users\Administrator\Desktop\demo.txt";
```

这样时无法得到我们想要的文件地址的，通常我们需要将字符串其中的C++保留字符进行转义才能够得到正确的字符串

```text
string filePath = "C:\\Users\\Administrator\\Desktop\\demo.txt";
```

如果时临时调试时需要直接将json串赋值给string,则需要写大量的转义字符，看得我们眼花缭乱。

如果我们想要将如下的json串直接赋值给string



```json
{
    "error": {
        "code": 101,
        "message": "operation failed!"
    },
    "result": false
}
```

我们就需要在中间加入大量的转义字符，才能够正确描述这么一段简短的json

```cpp
	QString json = "{\
		\"error\": {\
		\"code\": 101,\
		\"message\" : \"operation failed!\"\
		},\
		\"result\" : false\
		}";
```



有没有更好更直观的办法来描述呢？

答案是有的。

我们可以利用 `R"()"`源码转义，这样我们就不用编写大量的转义字符就可以描述多行的字符串了。

```cpp
QString json = R"({
    "error": {
        "code": 101,
        "message": "operation failed!"
    },
    "result": false
	})";
```



发布于 2021-02-02 14:29

[软件](https://www.zhihu.com/topic/19551718)

[生活](https://www.zhihu.com/topic/19551147)

[C / C++](https://www.zhihu.com/topic/19601705)