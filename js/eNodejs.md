# Node.js

```
apt install nodejs npm
node -v
npm -v
npm install cnpm -g --registry=http://registry.npm.taobao.org
# 命令先安装淘宝镜像的包命令行管理工具cnpm,然后再安装
cnpm install electron -g

npm install express
npm install express -g   # 全局安装
# npm config set proxy null
npm list -g
npm list grunt # 某个模块的版本号
npm uninstall express
npm ls
npm ls -g --depth=0

npm search express
npm update express
npm cache clean
npm init
npm publish
cnpm install [name]
```

### package.json
使用 package.json
package.json 位于模块的目录下，用于定义包的属性。接下来让我们来看下 express 包的 package.json 文件，位于 node_modules/express/package.json 内容：


Package.json 属性说明
name - 包名。
version - 包的版本号。
description - 包的描述。
homepage - 包的官网 url 。
author - 包的作者姓名。
contributors - 包的其他贡献者姓名。
dependencies - 依赖包列表。如果依赖包没有安装，npm 会自动将依赖包安装在 node_module 目录下。
repository - 包代码存放的地方的类型，可以是 git 或 svn，git 可在 Github 上。
main - main 字段指定了程序的主入口文件，require('moduleName') 就会加载这个文件。这个字段的默认值是模块根目录下面的 index.js。
keywords - 关键字
