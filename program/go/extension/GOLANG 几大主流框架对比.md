# [GOLANG 几大主流框架对比](http://qwding.github.io/post/golang_framwork_pk/)

CONTRAST OF GOLANG FRAMWORKS

NOVEMBER 25, 2016QWDING

1 MINUTE READ

### 先上表格

如下表格是2016-11-24 日调研结果，2~5列为github数据。 ![图片名称](http://qwding.github.io/img/golang_framwork_pk.png)

benchmark:

![图片名称](http://qwding.github.io/img/golang_framwork_benchmark.png)

### BEEGO VS REVEL VS MARTINI 三大老框架

beego

beego 很多人比较熟悉，国人写的，框架主要逻辑是经典MVC形式。

中间件：中间件可以写在beego内置的prepare方法里。

取参：取Query需要自己提取，url参数可以用内置方法。

返回：返回比较固定，想修改返回code比较麻烦。

缺点：

书写unit testing很恶心。

他的侵入式代码风格，还有源代码的多层嵌套，很多人都不太喜欢。

revel

revel 也是MVC框架，他的的形式是你在一个配置文件配置路由，当用revel工具执行revel run时候，将在项目目录下生产两个文件/tmp/main.go 和 /routs/routs.go .作用分别为注册路由和绑定路由内参数。

中间件：中间件可以定义在/init.go 里面。

取参：内置提供方法，并且有自己内置的validation方法，方便。

返回：提供多种返回方法。

缺点：

也是侵入式代码。

其他的未实际使用，不予评论

martini

书写简单，写起来和之后要讲的echo，gin很像，但是他的性能较echo和gin差了很多。

从功能上说，并且martini并不像beego和revel那样框架全面，需要自己把架子搭起来。

所以直接就不考虑了。

总结

性能上beego和revel两者不分伯仲，两者的侵入式代码也是为了节省更多的时间，带来了不少便利。对比起来更倾向于用revel做简单的web框架，他的取参和返回值带来的便利性更高一点，并且也会生成路由的testing方法，综合来讲下一次如果写简单的管理界面可能考虑使用revel。

### FASTHTTP VS HTTPROUTER

两者都作为http的框架，可以替代原生的http，他们的优越都是因为速度快，0占用内存著称。可以考虑将他们作为其他框架的http引擎，会提升很大速度。

### GORILLA MUX

gorilla 最大好处是他出发点为组件化，各个模块单独成一体，你需要哪个模块，拿过来用就行，不需要可以换成其他写法。

mux是帮你对router更容易管理，其速度来说并不是非常突出。但是docker swarm用的是gorilla mux，足见其有一定可用性。

对于gorilla其他模块，如果缺少哪个模块组件，完全去任你挑选，安全稳定可靠，开发好帮手。

### ECHO VS GIN

最想说的两个

无论哪个benchmark，这两个框架的benchmark都已绝对优势排在前列，性能绝对认可。

代码书写上，两个框架写法也很相似，非常简洁，几行代码可勾勒一个http server,如下为gin一个ping serve，是不是超级简单。

```
package main
import "github.com/gin-gonic/gin"
func main() {
    r := gin.Default()
    r.GET("/ping", func(c *gin.Context) {
        c.JSON(200, gin.H{
            "message": "pong",
        })
    })
    r.Run() // listen and server on 0.0.0.0:8080
}
```

而echo的写法和gin及其相似，就不列举了。

功能全面来说，虽然简洁，但是功能也很全面，从路由分组，取参，中间件，返回考虑，都封装的使用很舒服。

其他特点：

echo：

可以将http引擎从 echo.standerd 和fasthttp间切换，两者的性能差不太多。

自带工具全面：websocket, http2, jwt授权等。

具有中文文档。

gin：

日志跟踪比echo更强大，也内置了返回html文件的方法，所以去写web server也会很简单。

综合来说

两者相差不太大，但是gin的日志跟踪还是更舒服一点。

在以后如果想写简单的API server，我会首选gin或echo来使用，更倾向gin,如果你不想看英文文档可以选择echo。其使用的简单太吸引人了。

### GOJI 和 TANGO

这两个是顺便看的，也有一些人推崇这两个，但是使用起来差别也并不是特别大

tango出发点是以结构体作为执行体的灵活框架，其他好像也并无特色了

goji貌似更成熟一点，可依赖程度更高

### 总结

萝卜白菜，各有所爱。粗略调研统计，跟上时代步伐。

总结就是如果写简单web server 会考虑 revel，写api server 会首先考虑gin。

### 福利一句话

**上面的比较仅仅是路由的比较，但99%的瓶颈不在路由，而是模版的渲染和数据库操作。**

### LINK

- revel：http://revel.github.io/docs/godoc/template.html
- revel中文： http://gorevel.cn/docs/index.html
- beego: [http://beego.me](http://beego.me/)
- echo: https://echo.labstack.com/guide
- gin: https://github.com/gin-gonic/gin
- httpRouter: https://github.com/julienschmidt/httprouter
- gorilla: http://www.gorillatoolkit.org/pkg/
- tango: http://gobook.io/read/github.com/go-tango/manual-zh-CN/

benchmark:

- https://github.com/smallnest/go-web-framework-benchmark
- http://colobu.com/2016/03/23/Go-HTTP-request-router-and-web-framework-benchmark/