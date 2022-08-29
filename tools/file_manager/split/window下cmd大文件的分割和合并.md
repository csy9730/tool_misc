****

# window下cmd大文件的分割和合并

![img](https://upload.jianshu.io/users/upload_avatars/2815884/160b0518-3605-4d03-b20d-1b6c3163eb2d.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)

[Lozn情迁](https://www.jianshu.com/u/9b0768e66d01)关注

0.0972017.08.21 15:55:02字数 141阅读 22,816

大文件传输在电脑复制给手机就会出现卡死的情况，这时候咋办呢？

```swift
split -b 10000000000  Xcode_9_beta.zip
```

这里就是分割1g >split -b 1000000000 Xcode_9_beta.xip

生成了很多xaa xab xac
合并文件

#### 如何计算

```
5*1024*1024*1024*1024=5g
 5*1024*1024=5m
2g =2147483648
4g=4294967296
8g=8589934592
16g=17179869184
```

100m

#### 假设每一个文件100M

```
100*1024*1024`
`split -b 104857600 Ubuntu64.part1.rar
```



![img](https://upload-images.jianshu.io/upload_images/2815884-cfaf59c244562b1f.png?imageMogr2/auto-orient/strip|imageView2/2/w/851/format/webp)

image.png



### 合并

```go
copy /b xa*  xocdecopy.zip
```

下面是 对 当前目录分割好的文件进行合并.

```go
F:\360极速浏览器下载>copy /b xa* xcodecppy.zip
xaa
xab
xac
xad
xae
xaf
已复制         1 个文件。
```

如何校验是否完整呢，比对一下合成后的md5就好了
不过大文件检测md5还是比较累的哈。