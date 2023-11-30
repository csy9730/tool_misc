# [关于refs/for/ 和refs/heads/](https://www.cnblogs.com/onelikeone/p/6857932.html)

### refs/for/ 和refs/heads/
\1.   这个不是git的规则，而是gerrit的规则，

\2.   Branches, remote-tracking branches, and tags等等都是对commite的引用（reference）,引用都以 “refs/……”表示. 比如remote branch: origin/git_int(=refs/remotes/origin/git_int)， local tag: v2.0(=refs/tags/v2.0)， local branch: git_int(=refs/heads/git_int)…

\3.   简单点说，就是refs/for/mybranch需要经过code review之后才可以提交；refs/heads/mybranch不需要code review。

 

>（since you want to directly push into the branch, rather than create code reviews. Pushing to refs/for/* creates code reviews which must be approved and then submitted. Pushing to refs/heads/* bypasses review entirely, and just enters the commits directly into the branch. The latter does not check committer identity, making it appropriate for importing past project history）

如果需要code review，直接push
``` bash
git push origin master
```
那么就会有`“! [remote rejected] master -> master (prohibited by Gerrit)”`的错误信息

而这样push就没有问题，
``` bash
git push origin HEAD:refs/for/mybranch
```
 
### gerrit
下面一段是对“refs/for”更详细的描述：

 

> The documentation for Gerrit explains that you push to the "magical refs/for/'branch' ref using any Git client tool".

![img](https://images2015.cnblogs.com/blog/1164733/201705/1164733-20170515191144447-1318883271.png)

 

> This image is taken from the Intro to Gerrit. When you push to Gerrit, you do git push gerrit HEAD:refs/for/<BRANCH>. This pushes your changes to the staging area (in the diagram, "Pending Changes"). Gerrit doesn't actually have a branch called <BRANCH>; it lies to the git client.

 

> > Internally, Gerrit has it's own implementation for the Git and SSH stacks. This allows it to provide the "magical" refs/for/<BRANCH> refs.

 

> When a push request is received to create a ref in one of these namespaces Gerrit performs its own logic to update the database, and then lies to the client about the result of the operation. A successful result causes the client to believe that Gerrit has created the ref, but in reality Gerrit hasn’t created the ref at all. 

 

After a successful patch (i.e, the patch has been pushed to Gerrit, [putting it into the "Pending Changes" staging area], reviewed, and the review has passed), Gerrit pushes the change from the "Pending Changes" into the "Authoritative Repository", calculating which branch to push it into based on the magic it did when you pushed to refs/for/<BRANCH>. This way, successfully reviewed patches can be pulled directly from the correct branches of the Authoritative Repository.

 

转载自： http://lishicongli.blog.163.com/blog/static/146825902013213439500/

分类: [Git命令](https://www.cnblogs.com/onelikeone/category/1001087.html)