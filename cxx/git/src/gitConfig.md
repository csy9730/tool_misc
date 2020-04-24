# Git Config


## misc
在windows平台下git add 的时候经常会出现如下错误

git在windows下，默认是CRLF作为换行符，git add 提交时，检查文本中有LF 换行符（linux系统里面的），则会告警。所以问题的解决很简单，让git忽略该检查即可

`git config --global core.autocrlf warn `

Git提供了一个换行符检查功能（core.safecrlf），可以在提交时检查文件是否混用了不同风格的换行符。这个功能的选项如下：

false - 不做任何检查
warn - 在提交时检查并警告
true - 在提交时检查，如果发现混用则拒绝提交
建议使用最严格的 true 选项。
