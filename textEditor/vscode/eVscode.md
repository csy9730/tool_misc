# vscode
## base

${workspaceRoot} VS Code��ǰ�򿪵��ļ���
${file} ��ǰ�򿪵��ļ�
${relativeFile} �����workspaceRoot�����·��
${fileBasename} ��ǰ���ļ����ļ���
${fileDirname} ���ڵ��ļ��У��Ǿ���·��
${fileExtname} ��ǰ���ļ�����չ������.json

```
        {
            "name": "ʹ�ñ��� Chrome ����",
            "type": "chrome",
            "request": "launch",
             "file": "${workspaceRoot}/index.html",
        //  "url": "http://mysite.com/index.html", //ʹ���ⲿ������ʱ,��ע�͵� file, ���� url, ���� useBuildInServer ����Ϊ false "http://mysite.com/index.html
            "runtimeExecutable": "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe", // �ĳ����� Chrome ��װ·��
            "sourceMaps": true,
            "webRoot": "${workspaceRoot}",
        //  "preLaunchTask":"build",
            "userDataDir":"${tmpdir}",
            "port":5433
        }
```
