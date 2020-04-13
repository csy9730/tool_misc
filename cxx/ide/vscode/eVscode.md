# vscode

Vscode��һ�Դ�Ŀ�ƽ̨�༭��
## base

${workspaceRoot} VS Code��ǰ�򿪵��ļ���
${file} ��ǰ�򿪵��ļ�
${relativeFile} �����workspaceRoot�����·��
${fileBasename} ��ǰ���ļ����ļ���
${fileDirname} ���ڵ��ļ��У��Ǿ���·��
${fileExtname} ��ǰ���ļ�����չ������.json

## extension
### ʹ��Chrome����
�����ļ���̬���ԣ�
``` json
{
    "name": "ʹ�ñ��� Chrome ����",
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
url��̬���ԣ�
``` json
{
    "name": "ʹ�ñ��� Chrome ����",
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
**Q**: VS Code ������ʾ������ô�죿
**A**: �����Զ�����gbk�����utf8����:
��setting-Text Editor�е�"files.autoGuessEncoding"���ֵ��Ϊtrue���ɡ�


�������е�"files.autoGuessEncoding"���ֵ��Ϊtrue���ɡ�



**Q**: vscodeʹ�õ�����ΪӢ��(us)����ν�����ʾ�����޸ĳ������ˣ�
**A**: 
1����vscode���ߣ�
2��ʹ�ÿ�ݼ���ϡ�Ctrl+Shift+p�����������������롰configure display language�������ȷ����
3���޸�locale.json�ļ��µ����ԡ�locale��Ϊ��zh-CN��;
4������vscode���ߣ�
