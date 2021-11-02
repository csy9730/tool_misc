# Markdown表格中换行、合并单元格

[0蛐蛐0](https://www.jianshu.com/u/2584f54a7cb7)关注

0.9242019.07.19 10:48:39字数 220阅读 20,510

# 1、表格中内容对齐、换行

## 常规表格使用

一般我们都会这样用表格如下：

```ruby
| 姓名 | 年龄 |  爱好 |
| -- | -- | -- |
| 小明 | 9 | 篮球 |
| 小刚 | 10 | 篮球、足球 |
```

效果如下:

| 姓名 | 年龄 | 爱好       |
| ---- | ---- | ---------- |
| 小明 | 9    | 篮球       |
| 小刚 | 10   | 篮球、足球 |

## 设置对齐方式

`|:--:|`居中对齐`、|:--|`左对齐、`|--:|`右对齐。

```ruby
| 姓名 | 年龄 |  爱好 |
| :--: | :-- | --: |
| 小明 | 9 | 篮球 |
| 小刚 | 10 | 篮球、足球 |
```

效果如下:

| 姓名 | 年龄 |       爱好 |
| :--: | :--- | ---------: |
| 小明 | 9    |       篮球 |
| 小刚 | 10   | 篮球、足球 |

## 表格内容换行

Markdown本身不提供单元格换行，但是，Markdown是兼容HTML的，因此，我们可以通过HTML的方式实现单元格换行。

```ruby
| 姓名 | 年龄 |  爱好 |
| :-- | :-- | :-- |
| 小明 | 9 | 篮球 |
| 小刚 | 10 | 篮球 <br> 足球 |
```

效果如下:

| 姓名 | 年龄 | 爱好      |
| :--- | :--- | :-------- |
| 小明 | 9    | 篮球      |
| 小刚 | 10   | 篮球 足球 |

# 2、表格中单元格的合并

合并单元格还是要与HTML网页结合起来，来达到效果。

这会用到HTML的标签：

- `colspan`：规定单元格可纵深的列数
- `rowspan`：规定单元格可横跨的行数

## 合并表格行

```xml
<table>
    <tr>
        <td>张</td>
        <td>王</td>
    <tr>
    <tr>
        <td colspan="2">姓氏</td>
    <tr>
</table>
```

效果图：



![img](https://upload-images.jianshu.io/upload_images/2500114-f25b6d1d63a7966f.png?imageMogr2/auto-orient/strip|imageView2/2/w/902/format/webp)

合并行.png

## 合并表格列

```xml
<table>
    <tr>
        <td>类别</td>
        <td>名称</td>
    </tr>
    <tr>
        <td rowspan="2">颜色</td>
        <td>红色</td>
    </tr>
    <tr>
        <td>黄色</td>
    </tr>
    <tr>
        <td rowspan="2">姓氏</td>
        <td>张</td>
    </tr>
    <tr>
        <td>王</td>
    </tr>
</table>
```

效果图:



![img](https://upload-images.jianshu.io/upload_images/2500114-a34a3749881fb8c8.png?imageMogr2/auto-orient/strip|imageView2/2/w/960/format/webp)

合并列.png

## 综合使用

```xml
<table>
    <tr>
        <td>类别</td>
        <td>名称</td>
    </tr>
    <tr>
        <td rowspan="2">颜色</td>
        <td>红色</td>
    </tr>
    <tr>
        <td>黄色</td>
    </tr>
    <tr>
        <td colspan="2">姓氏</td>
    </tr>
    <tr>
        <td>王</td>
        <td>张</td>
    </tr>
</table>
```

效果图:



![img](https://upload-images.jianshu.io/upload_images/2500114-288c254f5ade3bac.png?imageMogr2/auto-orient/strip|imageView2/2/w/964/format/webp)

综合.png