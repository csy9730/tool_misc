# [javascript上传多张图片并预览](https://www.cnblogs.com/lgh344902118/p/8549863.html)



直接上代码

html代码

```
            <div>
                <label>封面</label>
                <input type="file" id="cover" name="cover">
                <img id="smallCover" width=200px height=200px>
            </div>
```

js代码

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
            $('#cover').on('change',function(){  
                var filePath = $(this)[0].files[0].name       //获取到input的value，里面是文件的路径  
                fileFormat = filePath.split('.')[1].toLowerCase()  
                src = window.URL.createObjectURL(this.files[0]) //转成可以在本地预览的格式  
                      
                // 检查是否是图片  
                if( !fileFormat.match(/png|jpg|jpeg/) ) {  
                    alert('上传错误,文件格式必须为：png/jpg/jpeg')
                    return   
                }  
            
                $('#smallCover').attr('src',src)
            });
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

以上是上传一张图片并预览

html就是一个类型是文件的input，下面放一个img用来预览。

js也很简单就是当其图片改变时转成本地预览格式，并判断图片后缀是否符合要求。

下面给出上传多张并预览

html代码

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```html
            <div>
                <label>图片</label>
                <input type="file" id="picture" multiple/>
            </div>
            <div id="previewImg">
            </div>
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

js代码

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```js
            $('#picture').on('change', function(){
                var imgFiles = $(this)[0].files
                for (i=0;i<imgFiles.length;i++){
                    filePath = imgFiles[i].name
                    fileFormat = filePath.split('.')[1].toLowerCase()  
                    src = window.URL.createObjectURL(imgFiles[i])
                    if( !fileFormat.match(/png|jpg|jpeg/) ) {  
                        alert('上传错误,文件格式必须为：png/jpg/jpeg')
                        return   
                    }
                    var preview = document.getElementById("previewImg")
                    var img = document.createElement('img')
                    img.width = 200
                    img.height = 200
                    img.src = src
                    preview.appendChild(img)
                }
            })
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

多张类似，只是多了个div，用for循环展示多张图