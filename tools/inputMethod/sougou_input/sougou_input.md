# sougou input



### SogouInput

C:\Program Files (x86)\SogouInput\6.1.0.6953
- ImeUtil.exe
- SogouCloud.exe
- PinyinUp.exe
- sogoupinyintray.exe
- SGTool.exe
- config.exe
- UserPage.exe


### 杀死搜狗输入法进程
```
taskkill /im PinyinUp.exe /f
taskkill /im ImeUtil.exe /f
taskkill /im SogouCloud.exe /f
taskkill /im rundll32.exe /f
taskkill /im SGTool.exe /f

```

系统的输入法服务。
`Rundll32.exe shell32.dll,Control_RunDLL C:\Windows\system32\input.dll`

### 如何禁止搜狗拼音恶意篡改Windows10系统默认输入法
