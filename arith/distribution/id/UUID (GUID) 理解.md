# UUID (GUID) 理解

![img](https://cdn2.jianshu.io/assets/default_avatar/9-cceda3cf5072bcdd77e8ca4f21c40998.jpg)

[Solomon_Xie](https://www.jianshu.com/u/55a28e472583)关注

0.9522019.01.15 03:31:22字数 492阅读 7,127

[参考：关于UUID的二三事](https://www.jianshu.com/p/d77f3ef0868a)

UUID，Universally Unique Identifier的缩写，**UUID出现的目的，是为了让分布式系统可以不借助中心节点，就可以生成UUID来标识一些唯一的信息。**
GUID，是Globally Unique Identifier的缩写，跟UUID是同一个东西，只是来源于微软。

1个UUID是1个16字节（128位）的数字；为了方便阅读，通常将UUID表示成如下的方式：
`123e4567-e89b-12d3-a456-426655440000`
它被`-`符号分为五段，形式为8-4-4-4-12的32个字符。
其中的字母是16进制表示，大小写无关。

UUID的标准格式：`xxxxxxxx-xxxx-Axxx-Bxxx-xxxxxxxxxxxx`
A那个位置，代表版本号，由于UUID的标准实现有5个版本，所以只会是1,2,3,4,5
B那个位置，只会是8,9,a,b

UUID在发展过程中，为了适应不同的需要，产生了5个版本：

- uuid1: 基于时间戳、机器MAC地址生成。由于使用MAC地址，可以保证全球范围的唯一性。
- uuid2: 只基于时间戳，不常用。
- uuid3: 基于namespace和一个自定义字符串，不常用。
- uuid4: 只基于随机数，最常用，但不推荐，重复几率不太能让人接受。
- uuid5: 只基于namespace，不常用。

## Python中生成UUID

[参考：Python——uuid](https://www.cnblogs.com/Security-Darren/p/4252868.html)

```py
>>> import uuid

>>> uuid.uuid1()
UUID('753be314-0512-11e9-9b06-d4619d2b8628')

>>>  uuid.uuid3(uuid.NAMESPACE_DNS, 'i am a name')
UUID('a7345f46-a3f1-33b7-99ae-a5e88194787d')

>>> uuid.uuid4()
UUID('fa9e34cc-2b31-41f0-8481-f703ce9a95b5')

>>> uuid.uuid5(uuid.NAMESPACE_DNS, 'i am a name')
UUID('1fd2308e-d846-5875-9106-9f6da736a562')
```

Python中UUID可以用int十进制，或hex十六进制显示，没有`-`分隔符用起来更方便。

```py
>>> uuid.uuid1().int
73221012087113356936998119716747445800

>>> uuid.uuid1().hex
'6e574a3e051211e99b06d4619d2b8628'
```

显示UUID的“字段”，即`-`分隔符分开的各个项：

```py
>>> uuid.uuid1().fields
(216362062, 1299, 4585, 155, 6, 233515713791528)
```

## UUID会不会重复？

[参考知乎：UUID是如何保证唯一性的？](https://www.zhihu.com/question/34876910)

如果是基于mac地址等多元素组合生成的UUID，那么基本上可以保证全球所有信息中的唯一性。



image



7人点赞

Database Based Basics 数据库研习