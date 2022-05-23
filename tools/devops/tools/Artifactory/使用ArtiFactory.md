# 使用ArtiFactory

![img](https://upload.jianshu.io/users/upload_avatars/2539449/1ab274fb-c88d-4455-ae64-6e26f48b71e5.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)

[技术客栈](https://www.jianshu.com/u/e3edf8d1b7ed)关注

0.2622018.05.30 10:58:55字数 643阅读 21,752

由于公司项目需要，现需要将一些公用的工具、组件、封装至Maven 仓库，以提供于其他项目的使用，避免复制粘贴的出现。众人拾柴火焰高。这样经过大家共同的努力，从而是该工具库变得更加的完善和健壮。为此使用ArtiFactory，当然也可以使用 [Bintray](https://bintray.com/)。亦是公司需要，使用ArtiFactory。
现做出记录：

注意：

```css
因为该工具的使用，需要使用Java JDK 1.8 以上，所以，在使用之前我们先检查下自己的JDK版本。 使用 java version 命令在控制台输出
自己JDK所在的开发环境的版本。
```

### 配置ArtiFactory环境

1、下载ArtiFactory ，下载地址：<https://bintray.com/>。下载完成之后解压进入bin 目录找到artifactory.bat文件点击直接运行，启动本地服务。测试是否成功的配置好来了artifactory 环境使用 ：<http://localhost:8081/artifactory>，看是否能够打开 Artifactory 界面。当我们创建Artifactory 的使用默认是为们提供了账号和密码,然后即可登陆。

> username = "admin"
> password = "password"

2、然后 New Local Repository，选择 Gradle 项目类型。并**填写Repository Key**该仓库的Key 你可以认为是一个分支。

### 项目中的使用

> **在我们项目的根 buil.gradle 文件中添加**

```bash
buildscript {
    repositories {
        jcenter()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:2.3.2'
        classpath "org.jfrog.buildinfo:build-info-extractor-gradle:3.1.1"
    
    }
}
```

> **在我们Module 文件的build.gradle 文件中配置**

```bash
apply plugin: 'com.jfrog.artifactory'
apply plugin: 'maven-publish'
```

> **配置POM 文件**

- 定义常量

```ruby
def MAVEN_LOCAL_PATH ='http://localhost:8081/artifactory'

def ARTIFACT_ID = 'utils'    //Utils common

def VERSION_NAME = '1.0.2'   //version Code

def GROUP_ID = 'com.andorid'        //packname
```

- 开始配置

  ```csharp
    def MAVEN_LOCAL_PATH ='http://localhost:8081/artifactory'
    def ARTIFACT_ID = 'utils'
    def VERSION_NAME = '1.0.2'
    def GROUP_ID = 'com.andorid'
    publishing {
        publications {
            aar(MavenPublication) {
                groupId GROUP_ID
                version = VERSION_NAME
                artifactId ARTIFACT_ID
                // Tell maven to prepare the generated "*.aar" file for publishing
                artifact("$buildDir/outputs/aar/${project.getName()}-release.aar")
                pom.withXml {
                    def dependencies = asNode().appendNode('dependencies')
                    configurations.compile.allDependencies.each{
                        // 如果有compile fileTree()，group会为空，需要去除
                        if(it.group != null) {
                            def dependency = dependencies.appendNode('dependency')
                            dependency.appendNode('groupId', it.group)
                            dependency.appendNode('artifactId', it.name)
                            dependency.appendNode('version', it.version)
                        }
                    }
                }
            }
        }
    }
  ```

> **配置Artifactory 上传**

```bash
    artifactory {
        contextUrl = MAVEN_LOCAL_PATH
        publish {
            repository {
                repoKey = 'demo-test-key'
                username = "admin"
                password = "password"
            }
            defaults {
                publications('aar')
                publishArtifacts = true
                properties = ['qa.level': 'basic', 'dev.team': 'core']
                publishPom = true
            }
        }
    }
```

**repoKey **该变量值为 在Artifactory 平台配置的仓库分支，也就是我们最终的代码将会在该目录下生成。

> **测试上传**

- 执行三步

  点击打开Module 项目的buildGradle 分别为以下三个步骤

  - build-->assembleRelease 生成Release 包
  - publishing-->generatePomFileForAarPublication 生成POM 文件
  - artifactoryPublish 上传aar 文件

然后我们即可在Artifactory 平台观测到我们刚才上传的aar 包文件。

## 使用方式##

> **在项目的根build.gradle 目录中添加如下代码**

```cpp
allprojects {
    repositories {
        jcenter()
        maven { url "http://localhost:8081/artifactory/demo-test-key/" }
    }
}

task clean(type: Delete) {
    delete rootProject.buildDir
}
```

这里需要说明的是*demo-test-key* 为我们repoKey 也就是仓库的分支。

> **项目的build.gradle 文件的配置**

```csharp
dependencies {
    ;;;;;;;;;;;;
    // 依赖配置
    compile 'com.andorid:utils:1.0.2'
}
```

#### 这里同样需要主要的是我们的依赖配置的定义规则如下

> **规则**

```css
 group_id : com.andorid
 artifact_id : utils
 version_name: 1.0.2
```

> 项目Gradle 依赖配置

```bash
group_id:artifact_Id:version_name  对比  'com.andorid:utils:1.0.2'
```





5人点赞



开发工具