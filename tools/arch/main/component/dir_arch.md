# 目录结构设计    


- [ ] design： 目录结构，

* public/customized/private/secret & others/ my
* filetype： dcim/
* tag： work/study/self


home


* downloads
* desktop
* software => install
    * windows
    * package/mirror/source
    * linux
    * android
    * ios/mac
    * web
    * Browser
    * python/anaconda
    * nodejs
* document
* pictures
* music
* videos
* project
    * githubs
    * private
        * todo queue
        * diary
        * sercret
        * others
    * work project
    * study 


# 文件目录结构



## 分类

类别后缀名：
* music ， 
* mov
* image， 
* text/markdown/pdf/doc/html ，
* exe/app，

用途分类
* work
* study
* live
* misc
* acg

size:
* tiny
* light
* middle
* heavy 

visitor priledge / ownership
* private
        * secret
        * hide
* static
        * others 
        * received/send/ 1 to 1
        * group share/
* public
        * from share & filter & add sth
        * totol public ( from github/baidu cloud share)
        *

home/app 
home/github
home/project
home/picture
home/public

## project结构

### flasky


* flask.py
* config.py
* app
    * api
        * users.py
    * main
        * view.py
    * static
    * template
    * auth
    * model.py
* migrations
* tests
* requirements


### yolov3

* train.py
* test.py
* utils
* data
* cfg
    * yolov3.cfg
* weights
    * download_yolov3_weights.sh