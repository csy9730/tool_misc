# 「GitHub」Python工具 - 添加、提取图片盲水印

[![VTester](https://pic1.zhimg.com/v2-13ad6d6eb3b52a1257af5aa64c5c5ba1_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/vtester-47)

[VTester](https://www.zhihu.com/people/vtester-47)

请务必坚持理想！带着理想，去远方！



4 人赞同了该文章

### 推荐一款添加、提取图片盲水印的Python工具 - Blind Watermark

> blind_watermark是一个可以添加、提取图片盲水印的Python工具，支持添加数字、嵌入图片、嵌入文本、嵌入二进制四种方式。可以防止旋转角度、随机截图、多遮挡、纵向裁剪、横向裁剪、缩放攻击等效果。



> 项目地址：[https://github.com/guofei9987/blind_watermark/](https://link.zhihu.com/?target=https%3A//github.com/guofei9987/blind_watermark/)
> 开源协议：MIT
> Star：1.4K
> Fork：200

### 安装

```text
pip install blind-watermark

# 或者安装最新开发版本
git clone git@github.com:guofei9987/blind_watermark.git
cd blind_watermark
pip install .
```

### 使用

**命令行中使用**

```text
# 嵌入水印：
blind_watermark --embed --pwd 1234 examples/pic/ori_img.jpeg "watermark text" examples/output/embedded.png

# 提取水印：
blind_watermark --extract --pwd 1234 --wm_shape 111 examples/output/embedded.png
```

嵌入文字水印

```text
from blind_watermark import WaterMark

bwm1 = WaterMark(password_img=1, password_wm=1)
bwm1.read_img('pic/ori_img.jpg')
wm = '@guofei9987 开源万岁！'
bwm1.read_wm(wm, mode='str')
bwm1.embed('output/embedded.png')
len_wm = len(bwm1.wm_bit)
print('Put down the length of wm_bit {len_wm}'.format(len_wm=len_wm))
```

提取文字水印

```text
bwm1 = WaterMark(password_img=1, password_wm=1)
wm_extract = bwm1.extract('output/embedded.png', wm_shape=len_wm, mode='str')
print(wm_extract)
```

嵌入图片水印

```text
from blind_watermark import WaterMark

bwm1 = WaterMark(password_wm=1, password_img=1)
# read original image
bwm1.read_img('pic/ori_img.jpg')
# read watermark
bwm1.read_wm('pic/watermark.png')
# embed
bwm1.embed('output/embedded.png')
```

提取图片水印

```text
bwm1 = WaterMark(password_wm=1, password_img=1)
# notice that wm_shape is necessary
bwm1.extract(filename='output/embedded.png', wm_shape=(128, 128), out_wm_name='output/extracted.png', )
```

### 各种攻击后的效果

![img](https://pic1.zhimg.com/80/v2-416c8ba651c0ec69a64d05810b148670_720w.jpg)

> 感谢阅读！如果我的文章对您有所帮助，烦请给个关注或者私信。一起交流学习！

![img](https://pic2.zhimg.com/80/v2-e7dca2887086d5a6c821d363ecf340c1_720w.jpg)



编辑于 2022-03-06 10:34

Python 入门

Python

GitHub

赞同 4

分享