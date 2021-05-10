# Java后端模板引擎对比

[![木小丰](https://pic1.zhimg.com/e07954953_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/lesofn)

[木小丰](https://www.zhihu.com/people/lesofn)

公共号：Java研发，关注分布式架构、软件工程、全栈等



2 人赞同了该文章

## 一、什么是模板引擎

模板引擎是为了解决用户界面（显示）与业务数据（内容）分离而产生的。他可以生成特定格式的文档，常用的如格式如HTML、xml以及其他格式的文本格式。其工作模式如下：



![img](https://pic2.zhimg.com/80/v2-6191c56f51bceebc00d0f74b2d0c6739_720w.jpg)



## 二、java常用的模板引擎有哪些

jsp：是一种动态网页开发技术。它使用JSP标签在HTML网页中插入Java代码。

Thymeleaf : 主要渲染xml，HTML，HTML5而且与springboot整合。

Velocity：不仅可以用于界面展示（HTML.xml等）还可以生成输入java代码，SQL语句等文本格式。

FreeMarker：功能与Velocity差不多，但是语法更加强大，使用方便。

## 三、常用模板引擎对比

由于jsp与thymeleaf主要偏向于网页展示，而我们的需求是生成java代码与mybatis配置文件xml。顾这里只对Velocity与FreeMarker进行对比。

示例：1万次调用动态生成大小为25kb左右的mybatisxml文件

### 1、Velocity 模板文件

```text
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${mapperName}">

    #foreach($map in $methodList)
        #if(${map.sqlType} == "select")
            <select id="${map.methodName}" resultType="${map.type}">
                ${map.desc}
            </select>
            #elseif(${map.sqlType} == "insert")
                <insert id="${map.methodName}" resultType="${map.type}">
                    ${map.desc}
                </insert>
            #else
        #end

    #end
</mapper>
```

### 2、Velocity java执行代码

```text
public class VelocityTest {

    public static void main(String[] args) {
        //得到VelocityEngine
        VelocityEngine ve = new VelocityEngine();
        //得到模板文件
        ve.setProperty(Velocity.FILE_RESOURCE_LOADER_PATH, "/Users/huhaiquan/project/database-proxy/database-proxy-server/src/test/resources");
        ve.init();
        Template template = ve.getTemplate("velocity.vm", "UTF-8");
        VelocityContext data = new VelocityContext();

        data.put("mapperName", "com.xxx.mapperName");
        List<Map> methodList = DataUtils.createData(200);
        data.put("methodList", methodList);

        try {
            //生成xml
            //调用merge方法传入context
            int num = 1;
            int total=10000;
            for (int i=0;i<num;i++){
                StringWriter stringWriter = new StringWriter();
                long curr = System.currentTimeMillis();

                template.merge(data, stringWriter);
                long end = System.currentTimeMillis();
//                stringWriter.flush();
                total+=(end-curr);

            }
            System.out.println("total="+total+",vag="+(total*1f/num));

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

### 3、FreeMarker 模板文件

```text
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${mapperName}">

<#list methodList as method>
    <#if "${method.sqlType}" =="select">
     <select id="${method.methodName}"  resultType="${method.type}">
         ${method.desc}
     </select>
    <#elseif "${method.sqlType}" == "insert">
      <insert id="${method.methodName}" resultType="${method.type}">
          ${method.desc}
      </insert>
    </#if>
</#list>
</mapper>
```

### 4、FreeMarker 执行代码

```text
public class FreeMTest {

    public static Template getDefinedTemplate(String templateName) throws Exception{
        //配置类
        Configuration cfg = new Configuration(Configuration.VERSION_2_3_22);
        cfg.setDirectoryForTemplateLoading(new File("/Users/huhaiquan/project/database-proxy/database-proxy-server/src/test/resources/"));
        cfg.setDefaultEncoding("UTF-8");
        cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
        return cfg.getTemplate(templateName);
    }


    public static void main(String[] args){
        Map<String,Object> data = new HashMap<>();
        data.put("mapperName", "com.xxx.mapperName");
        List<Map> methodList =DataUtils.createData(200);
        data.put("methodList", methodList);
        try {
            Template template = getDefinedTemplate("freemarker.ftl");

            long total = 0;
            int num = 10000;
            for (int i=0;i<num;i++){
                StringWriter stringWriter = new StringWriter();
                long curr = System.currentTimeMillis();
                template.process(data,stringWriter);
                long end = System.currentTimeMillis();
                total+=(end-curr);
            }
            System.out.println("total="+total+",vag="+(total/num));

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

## 四、特性对比

项目名称版本10000次执行耗时社区支持文件语法功能Velocity2.112833ms较差较少简单，接近java一般FreeMarker2.3.284599ms较好较多简单强大，在日期、数字，国际化方面有健全的处理机制。

结果：虽然网上对比结果一致为Velocity的性能高于FreeMarker,但是我的测试结果却完全相反，可能跟版本有关。语法方面，Velocity更接近java语法，学习成本低，FreeMarker本身提供的语法也相对简单。FreeMarker在社区支持，功能方面要比Velocity强大的多。

## 五、参考：

[https://www.runoob.com/jsp/jsp-tutorial.html](https://link.zhihu.com/?target=https%3A//www.runoob.com/jsp/jsp-tutorial.html)
[https://www.thymeleaf.org/](https://link.zhihu.com/?target=https%3A//www.thymeleaf.org/)
[https://blog.csdn.net/xiang__liu/article/details/81160766](https://link.zhihu.com/?target=https%3A//blog.csdn.net/xiang__liu/article/details/81160766)
[http://freemarker.foofun.cn/](https://link.zhihu.com/?target=http%3A//freemarker.foofun.cn/)
[https://www.iteye.com/blog/lishumingwm163-com-933365](https://link.zhihu.com/?target=https%3A//www.iteye.com/blog/lishumingwm163-com-933365)

博客链接：

Java后端模板引擎对比 | 木小丰的博客lesofn.com![图标](https://pic2.zhimg.com/v2-ee90254b45969be247d822c646ac6eb9_180x120.jpg)



编辑于 2020-12-26

freemarker

JSP

HTML