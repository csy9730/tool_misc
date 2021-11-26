# Electron VS NW.js

Electron 以前被称为 Atom Shell。

NW.js (previously known as node-webkit)

比较NW.js和Electron之前，先要明白虽然是用javascript+html写的app，但是都会跑两部分的js runtime，分别是node-runtime和chromium-runtime。

功能上看，2者差不多，主要的区别是入口方式。

Electron是基于node的，入口是类似node module的index.js，这是因为Electron是基于node的event-loop将chromium的功能和event全部整合app，Electron的开发跟其他的node应用没区别。

NW.js像一个跑在node-platform上的浏览器，所以他的入口是index.html，NW.js将自己的功能都整合进了chromium-runtime，因此更接近一个前端的应用开发方式。NW.js也可以用到node的api，这是通过binding到chromium-runtime来调用的。

进一步说，NW把2套js-runtime环境整合到了一起，Electron则是保持2套js-runtime彼此独立。因此NW的app中的js代码可以使用所有的API（这不见得是好事）。electron的app中的js是可以分前后端的。（传说中的full-stack）

个人小结：

- 两个框架看似功能一样，但其实可以用前后端的差别来看待彼此。(网络请求，I/O操作, etc.)
- 用node module在web端是没有的，有Electron需要其实是需要关闭nodeIntegeration来兼容web资源的依赖加载。
- NW.js对库的整合更深，某种意义上说，对chromium和Node有更深入的理解（新功能要用，必须把源码拿来build进去）。
- Electron对chromium和node的整合更灵活，更新一些新功能完成度会更方便(chromium社区是很活跃的，有新版可以随时拿来)，可以把开发的精力放在其他地方。
- Electron对其他Node的应用，可以有更好的整合。因为他本身也是一个node应用。NW只能用node.js的API
- 从license上来看，Electron是Github的，NW.js则是Intel。



