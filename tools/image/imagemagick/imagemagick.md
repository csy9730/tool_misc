# imagemagick

[https://imagemagick.org/script/index.php](https://imagemagick.org/script/index.php)

> ImageMagick is free software delivered as a ready-to-run binary distribution or as source code that you may use, copy, modify, and distribute in both open and proprietary applications. It is distributed under a derived Apache 2.0 license.

> ImageMagick utilizes multiple computational threads to increase performance and can read, process, or write mega-, giga-, or tera-pixel image sizes.

### help
[https://imagemagick.org/script/magick.php](https://imagemagick.org/script/magick.php)

[https://imagemagick.org/script/command-line-options.php](https://imagemagick.org/script/command-line-options.php)
### demo
#### ImageMagick 拼图方法
合并图片 
用法：
``` bash
magick 1.jpg +append 2.jpg 3.jpg .... 0.jpg
# 把 1.jpg、2.jpg、3.jpg等多张图片沿“水平方向”（ +append）拼成 0.jpg（最后一个文件名是拼出的成品）

magick 1.jpg -append 2.jpg 3.jpg .... 0.jpg
#　把 1.jpg、2.jpg、3.jpg等多张图片沿“垂直方向”（ -append）拼成 0.jpg（最后一个文件名是拼出的成品）
可以分两步，第一步把小图拼成多个水平方向的长条，第二步把长条按垂直方向合并成一个大图。
```

#### 切图
切割图片 
ImageMagick 方法：
``` bash
magick 1.jpg  -crop 128x128 0.jpg
# 把大图1.jpg按128x128分割成了多张小图0-1.jpg  0-2.jpg ...
  
magick 1.jpg  -crop 128x64+6+7 0.jpg
#从1.jpg 以座标 6,7 为起点切一片 128x64 的块生成 0.jpg

magick.exe 0.jpg -crop 448x512+0+0  1.jpg
# 从0.jpg 以座标 0,0 为起点切一片 448x512 的块生成你要的 1.jpg，相当于右边剪裁掉64像素

```


#### 锐化
ImageMagick 方法：
``` bash
convert -sharpen 5 0.jpg 1.jpg
# 将0.jpg 锐化后生成1.jpg，锐化指数5，此数值越大，锐化度越高，图像细节损失越大
```
