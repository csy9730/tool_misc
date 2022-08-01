# SVG 路径 ＜path＞ 格式指令解析M/L/H/V/C/S/Q/T/A/Z



技术标签： [杂七杂八](https://www.codeleading.com/tag/%E6%9D%82%E4%B8%83%E6%9D%82%E5%85%AB/)  [svg](https://www.codeleading.com/tag/svg/)  [SVG](https://www.codeleading.com/tag/SVG/)  [指令](https://www.codeleading.com/tag/%E6%8C%87%E4%BB%A4/)  [格式](https://www.codeleading.com/tag/%E6%A0%BC%E5%BC%8F/)  [path](https://www.codeleading.com/tag/path/)



## 指令

- M = `moveto`
- L = `lineto`
- H = `horizontal lineto`
- V = `vertical lineto`
- C = `curveto`
- S = `smooth curveto`
- Q = `quadratic Bézier curve`
- T = `smooth quadratic Bézier curveto`
- A = `elliptical Arc`
- Z = `closepath`

注意：以上所有命令均允许小写字母。大写表示绝对定位，小写表示相对定位。

## 例子

### 绘制三角形
![在这里插入图片描述](https://www.codeleading.com/imgrdrct/https://img-blog.csdnimg.cn/d5600902c4954dac9055996331f99fc3.png)

```xml
<svg xmlns="http://www.w3.org/2000/svg" version="1.1">
    <path d="M150 0 L75 200 L225 200 Z" />
</svg>
```

### 绘制圆弧
![在这里插入图片描述](https://www.codeleading.com/imgrdrct/https://img-blog.csdnimg.cn/472046577ac64a16b407ca6246af5973.jpeg)

```xml
<?xml version="1.0" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg width="50" height="50" title="polygons" version="1.1" viewBox="0 0 50 50" xmlns="http://www.w3.org/2000/svg" class="svg-paper">
  <g>
    <desc>pwidth:50;pheight:50;</desc>
    <path
       stroke="#000000"
       stroke-width="0.4mm"
       fill="none"
       d="M35,25L35,25L34.99,24.51L34.95,24.02L34.89,23.53L34.81,23.05L34.7,22.57L34.57,22.10L34.41,21.63L34.24,21.17L34.04,20.72L33.82,20.29L33.58,19.86L33.31,19.44L33.03,19.04L32.73,18.66L32.41,18.28L32.07,17.93L31.72,17.59L31.34,17.27L30.96,16.97L30.56,16.69L30.14,16.42L29.71,16.18L29.28,15.96L28.83,15.76L28.37,15.59L27.90,15.43L27.43,15.30L26.95,15.19L26.47,15.11L25.98,15.05L25.49,15.01L25,15L24.51,15.01L24.02,15.05L23.53,15.11L23.05,15.19L22.57,15.30L22.10,15.43L21.63,15.59L21.17,15.76L20.72,15.96L20.29,16.18L19.86,16.42L19.44,16.69L19.04,16.97L18.66,17.27L18.28,17.59L17.93,17.93L17.59,18.28L17.27,18.66L16.97,19.04L16.69,19.44L16.42,19.86L16.18,20.29L15.96,20.72L15.76,21.17L15.59,21.63L15.43,22.10L15.3,22.57L15.19,23.05L15.11,23.53L15.05,24.02L15.01,24.51L15,25L15.01,25.49L15.05,25.98L15.11,26.47L15.19,26.95L15.3,27.43L15.43,27.90L15.59,28.37L15.76,28.83L15.96,29.28L16.18,29.71L16.42,30.14L16.69,30.56L16.97,30.96L17.27,31.34L17.59,31.72L17.93,32.07L18.28,32.41L18.66,32.73L19.04,33.03L19.44,33.31L19.86,33.58L20.29,33.82L20.72,34.04L21.17,34.24L21.63,34.41L22.10,34.57L22.57,34.7L23.05,34.81L23.53,34.89L24.02,34.95L24.51,34.99L25,35L25.49,34.99L25.98,34.95L26.47,34.89L26.95,34.81L27.43,34.7L27.90,34.57L28.37,34.41L28.83,34.24L29.28,34.04L29.71,33.82L30.14,33.58L30.56,33.31L30.96,33.03L31.34,32.73L31.72,32.41L32.07,32.07L32.41,31.72L32.73,31.34L33.03,30.96L33.31,30.56L33.58,30.14L33.82,29.71L34.04,29.28L34.24,28.83L34.41,28.37L34.57,27.90L34.7,27.43L34.81,26.95L34.89,26.47L34.95,25.98L34.99,25.49"/>

  </g>
</svg>
```



版权声明：本文为kangweijian原创文章，遵循[ CC 4.0 BY-SA ](https://creativecommons.org/licenses/by-sa/4.0/)版权协议，转载请附上原文出处链接和本声明。

本文链接：[https://blog.csdn.net/kangweijian/article/details/125169164](https://blog.csdn.net/kangweijian/article/details/125169164)