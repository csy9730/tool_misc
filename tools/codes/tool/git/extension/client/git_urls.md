# git urls

git 支持ssh，git，http，https协议。此外，也支持ftp和ftps协议，ftp和ftps协议已被废弃，避免使用 。

> Git supports ssh, git, http, and https protocols (in addition, ftp, and ftps can be used for fetching, but this is inefficient and deprecated; do not use it).

``` bash
ssh://[user@]host.xz[:port]/~[user]/path/to/repo.git/

git://host.xz[:port]/~[user]/path/to/repo.git/

[user@]host.xz:/~[user]/path/to/repo.git/

# scp
[user@]host.xz:path/to/repo.git/
```


```
git remote set-url --add origin https://github.com/abc/a_repo.git
git remote set-url --add origin ssh://git@server/home/git/abc/a_repo.git
git remote set-url --add origin git@gitee.com:abc/a_repo.git
```

git://192.168.0.113:30122/chensy/111.git

ssh://git@192.168.100.18:hello-world.git 
http://192.168.0.113:30180/chensy/111
ssh://[user@]host.xz[:port]/~[user]/path/to/repo.git/

ssh://git@192.168.100.18:30122/chensy/111.git
ssh://git@192.168.0.113:30122/chensy/111

stderr: fatal: protocol error: bad line length character: SSH-

ssh://git@192.168.100.18:hello-world.git 