# Git diff for .docx  format  file



Use pandoc to realize it.



``` bas
Install pandoc
sudo apt-get install pandoc
```




Create or edit file ~/.gitconfig to add

``` in
[diff "pandoc"]
     textconv=pandoc --to=markdown
     prompt = false
[alias]
     wdiff = diff --word-diff=color --unified=1
```

In git working directory, create or edit file .gitattributes
*.docx diff=pandoc

Use git wdiff to show diff  between commits and working tree or between two commits  for .docx file, commitsId can get use command git log

``` bas
git wdiff file.docx

git wdiff commitsId1 commitsId2 file.docs
```



