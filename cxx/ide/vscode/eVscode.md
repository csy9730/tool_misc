# vscode
## base

${workspaceRoot} VS Code当前打开的文件夹
${file} 当前打开的文件
${relativeFile} 相对于workspaceRoot的相对路径
${fileBasename} 当前打开文件的文件名
${fileDirname} 所在的文件夹，是绝对路径
${fileExtname} 当前打开文件的拓展名，如.json

## extension
### 使用Chrome调试
本地文件静态调试：
``` json
{
    "name": "使用本机 Chrome 调试",
    "type": "chrome",
    "request": "launch",
    "file": "${workspaceRoot}/index.html",
    "runtimeExecutable": "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe",
    "sourceMaps": true,
    "webRoot": "${workspaceRoot}",
    "userDataDir":"${tmpdir}",
    "port":5433
}
```
url动态调试：
``` json
{
    "name": "使用本机 Chrome 调试",
    "type": "chrome",
    "request": "launch",
    "url": "http://mysite.com/index.html",
    "runtimeExecutable": "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe", 
    "sourceMaps": true,
    "webRoot": "${workspaceRoot}",
    "preLaunchTask":"build",
    "userDataDir":"${tmpdir}",
    "port":5433
}
```
### python
``` json
{
    "python.pythonPath": "E:\\ProgramData\\Anaconda3\\envs\\zal_platform\\python.exe"
}
```

### vim
### peacock


### cn
**Q**: 如何开启自动区分gbk编码和utf8编码
**A**: 将setting-Text Editor中的"files.autoGuessEncoding"项的值改为true即可。
