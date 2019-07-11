# gitbook

## 安装


1. 安装 node.js 和npm
2. npm install -g gitbook-cli
3. gitbook -V 
4. gitbook install 
5. 安装calibrate (可选)



### misc



**Q** : Error: ENOENT: no such file or directory, stat 'C:\Users\CSY_AC~1\AppData\Local\
Temp\tmp-1397236171qco2SJ6\gitbook\gitbook-plugin-highlight\ebook.css'

**A** :打开C:\Users\admin\.gitbook\versions\3.2.3\copyPluginAssets.js，替换所有`confirm: true` 为 `confirm: false`

