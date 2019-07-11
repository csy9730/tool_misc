# vscode
## base

${workspaceRoot} VS Code当前打开的文件夹
${file} 当前打开的文件
${relativeFile} 相对于workspaceRoot的相对路径
${fileBasename} 当前打开文件的文件名
${fileDirname} 所在的文件夹，是绝对路径
${fileExtname} 当前打开文件的拓展名，如.json

```
        {
            "name": "使用本机 Chrome 调试",
            "type": "chrome",
            "request": "launch",
             "file": "${workspaceRoot}/index.html",
        //  "url": "http://mysite.com/index.html", //使用外部服务器时,请注释掉 file, 改用 url, 并将 useBuildInServer 设置为 false "http://mysite.com/index.html
            "runtimeExecutable": "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe", // 改成您的 Chrome 安装路径
            "sourceMaps": true,
            "webRoot": "${workspaceRoot}",
        //  "preLaunchTask":"build",
            "userDataDir":"${tmpdir}",
            "port":5433
        }
```
