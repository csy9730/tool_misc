# [基于Velocity开发自己的模板引擎](https://www.cnblogs.com/zfyouxi/p/4309527.html)



Velocity是一个基于java的模板引擎（template engine）。它同意不论什么人只简单的使用模板语言（template language）来引用由java代码定义的对象。 

当Velocity应用于web开发时，界面设计人员能够和java程序开发者同步开发一个遵循MVC架构的web网站，也就是说，页面设计人员能够仅仅 关注页面的显示效果，而由java程序开发者关注业务逻辑编码。Velocity将java代码从web页面中分离出来，这样为web网站的长期维护提 供了便利，同一时候也为我们在JSP，PHP和Freemarker之外又提供了一种可选的方案。 

大多数开发者只了解上述部分，即Velocity能够作为MVC的V，所以出现了非常多Velocity和SpringMVC，Velocity和Struts集成的设计。但少有人关注，Velocity作为模板引擎的意义，既然是模板引擎，那它就不应该只局限在MVC的领域。

**Velocity的能力远不止web网站开发这个领域，比如，它能够从模板（template）产生SQL和PostScript、XML，它也能够被当 作一个独立工具来产生源码和报告，或者作为其它系统的集成组件使用。**



下面代码，是我对Velocity的简单封装，能够将Velocity作为单独的组件来使用，稍加丰富就能够成为我们应用的模板引擎。

**核心代码：**

``` java
package com.ths.platform.framework.template;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.util.Properties;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;
import org.apache.velocity.app.VelocityEngine;

public class VelocityParser
{
    //模板上下文
    private VelocityContext mainContext;
    //模板对象
    private Template mainTemplate;
    //模板引擎
    private VelocityEngine velocityEngine;
    //模板引擎初始化參数
    private  Properties properties;

    public static void main( String[ ] args ) {
        String filepath = "template/view.jsp";
        VelocityParser velocityParser = new VelocityParser( filepath );
        velocityParser.addToContext( "title" , "HelloWorld" );
        velocityParser.processTemplate( );
    }

    /**
     * @MethodName	: addToContext
     * @Description	: 向模板上下文中加入參数
     * @param key
     * @param value
     */
    public void addToContext( String key, Object value ) {
        if ( mainContext == null )
        {
            mainContext = new VelocityContext( );
        }

        mainContext.put( key , value );
    }

    /**
     * @MethodName	: addToContext
     * @Description	:初始化模板上下文
     * @param chainCtx
     */
    public void addToContext( VelocityContext chainCtx ) {
        mainContext = new VelocityContext( chainCtx );
    }

    /**
     * @MethodName	: processTemplate
     * @Description	: 输出到控制台
     */
    public void processTemplate() {
        try
        {
            BufferedWriter writer = new BufferedWriter( new OutputStreamWriter( System.out ) );
            if ( mainTemplate != null )
            {
                mainTemplate.merge( mainContext , writer );
            }

            writer.flush( );
            writer.close( );
        }
        catch ( Exception ex )
        {
            ex.printStackTrace( );
        }
    }
    
    /**
     * @MethodName	: processTemplate
     * @Description	: 输出到文件
     * @param destPath
     */
    public void processTemplate(String destPath) {
        try
        {
            OutputStream os = new FileOutputStream(destPath);
            OutputStreamWriter writer = new OutputStreamWriter(os, "UTF-8");
            
            if ( mainTemplate != null )
            {
                mainTemplate.merge( mainContext , writer );
            }

            writer.flush( );
            writer.close( );
        }
        catch ( Exception ex )
        {
            ex.printStackTrace( );
        }
    }

    /**
     * 依据模板文件初始化模板引擎
     * @param templateFile
     */
    public VelocityParser( String templateFile ) {
         this(templateFile , null);
    }

    /**
     * 依据模板文件和模板上下文（參数）初始化模板引擎
     * @param templateFile
     * @param chainContext
     */
    public VelocityParser( String templateFile , VelocityContext chainContext ) {
        try
        {
            //新建模板引擎
            velocityEngine = new VelocityEngine( );
            
            //获取初始化參数
            properties = initProperties( );

            //初始化模板引擎
            velocityEngine.init( properties );
            
            //获取模板对象
            mainTemplate = velocityEngine.getTemplate( templateFile );
            
            //设置模板上下文
              if(chainContext!=null){
                //设置模板上下文
                mainContext = chainContext;
            }

        }
        catch ( Exception ex )
        {
            System.out.println( "Error processing template file: " + templateFile );
        }
    }

    /**
     * @MethodName	: initProperties
     * @Description	: 设置初始化參数
     * @return
     */
    private Properties initProperties() {
        Properties properties = new Properties( );
        //设置从classpath中载入模板文件
        properties.setProperty( Velocity.FILE_RESOURCE_LOADER_PATH , Thread.currentThread( )
                .getContextClassLoader( ).getResource( "" ).getPath( ) );
        //解决模板中文乱码
        properties.setProperty( Velocity.INPUT_ENCODING , "utf-8" );
        properties.setProperty( Velocity.OUTPUT_ENCODING , "utf-8" );
        return properties;
    }

}
```

模板：

``` xml
 <table> 
 <tr><td>$title</td></tr> 
 </table>
```

运行main方法，就可以在控制台输出模板和參数合并后生成的数据。



有了这段代码，仅仅要开发过程中，再涉及到反复劳动，再涉及到输出什么报告，仅仅要你能抽取出模板，其它工作，就让它滚犊子去吧。