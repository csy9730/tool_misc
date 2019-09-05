

从所有版本中删除文件

``` bash
git filter-branch -f --tree-filter 'rm tools/abc.exe' HEAD 
git push origin --force
```

