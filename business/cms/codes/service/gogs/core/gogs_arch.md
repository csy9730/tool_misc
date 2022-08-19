# gogs

###  sql

提供了以下的表
- user: id,name, type, **
- org_user: uid org_id, **
- team: id, org_id, name, author_level, **
- team_user: (uid), org_id, team_id,
- team_repo: (org_id), team_id, repo_id
- repo: id, owner_id, name, 

org 和 user 共用id，这样设计可以便于个人用户和组织用户的切换。


