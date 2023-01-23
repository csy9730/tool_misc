# gogs api

gogs 提供了以下api接口，便于使用
- 获取用户令牌
- 获取用户所有仓库信息
- 搜索用户仓库信息
- 迁移仓库


### /api/v1/users/{user}/tokens
```
curl -u "foo" http://localhost:3000/api/v1/users/foo/tokens

[{"name":"111","sha1":"ce55c8bb682f4ec5ea615e2d0e7f2d9423ba998f"}]



curl -u "foo" http://foo2:13130/api/v1/users/foo/tokens
curl -u "foo" http://localhost:30130/api/v1/users/foo/tokens

```

### /api/v1/repos/search
可以搜索用户仓库信息
### /api/v1/user/repos
可以获取用户的所有仓库信息

```
ACCESS_TOKEN = ce55c8bb682f4ec5ea615e2d0e998f7f2d9423ba
$ curl -H "Authorization: token {ACCESS_TOKEN}" https://localhost/api/v1/user/repos
$ curl https://try.gogs.io/api/v1/user/repos?token={ACCESS_TOKEN}

curl -H "Authorization: token ce55c8bb682f4ec5ea615e2d0e998f7f2d9423ba" https://localhost:3000/api/v1/user/repos

curl https://localhost:3000/api/v1/user/repos?token=ce55c8bb682f4ec5ea615e2d0e998f7f2d9423ba

curl: (35) schannel: next InitializeSecurityContext failed: SEC_E_INVALID_TOKEN (0x80090308) - 缁欏嚱鏁版彁渚涚殑鏍囧織鏃犳晥

curl -H "Authorization: token ce55c8bb682f4ec5ea615e2d0e998f7f2d9423ba" http://foo2:13130/api/v1/user/repos

```

``` json
[
    {
        "id": 35,
        "owner": {
            "id": 1,
            "username": "foo",
            "login": "foo",
            "full_name": "",
            "email": "foo@163.com",
            "avatar_url": "https://secure.gravatar.com/avatar/7ba79b967a4f7bfd815110285c585354?d=identicon"
        },
        "name": "nocode",
        "full_name": "foo/nocode",
        "description": "",
        "private": false,
        "fork": false,
        "parent": null,
        "empty": false,
        "mirror": false,
        "size": 1709056,
        "html_url": "http://localhost:3000/foo/nocode",
        "ssh_url": "git@localhost:foo/nocode.git",
        "clone_url": "http://localhost:3000/foo/nocode.git",
        "website": "",
        "stars_count": 0,
        "forks_count": 0,
        "watchers_count": 1,
        "open_issues_count": 0,
        "default_branch": "master",
        "created_at": "2021-11-14T02:44:51Z",
        "updated_at": "2021-11-14T02:44:54Z",
        "permissions": {
            "admin": true,
            "push": true,
            "pull": true
        }
    },
    {
        "id": 3,
        "owner": {
            "id": 1,
            "username": "foo",
            "login": "foo",
            "full_name": "",
            "email": "foo@163.com",
            "avatar_url": "https://secure.gravatar.com/avatar/7ba79b967a4f7bfd815110285c585354?d=identicon"
        },
        "name": "tool_misc2",
        "full_name": "foo/tool_misc2",
        "description": "",
        "private": false,
        "fork": false,
        "parent": null,
        "empty": false,
        "mirror": true,
        "size": 22916096,
        "html_url": "http://localhost:3000/foo/tool_misc2",
        "ssh_url": "git@localhost:foo/tool_misc2.git",
        "clone_url": "http://localhost:3000/foo/tool_misc2.git",
        "website": "",
        "stars_count": 0,
        "forks_count": 0,
        "watchers_count": 1,
        "open_issues_count": 0,
        "default_branch": "master",
        "created_at": "2021-02-13T14:11:30Z",
        "updated_at": "2021-11-11T07:18:20Z",
        "permissions": {
            "admin": true,
            "push": true,
            "pull": true
        }
    },
    {
        "id": 25,
        "owner": {
            "id": 8,
            "username": "githubs",
            "login": "githubs",
            "full_name": "",
            "email": "",
            "avatar_url": "http://localhost:3000/avatars/8"
        },
        "name": "flask_microblog",
        "full_name": "githubs/flask_microblog",
        "description": "",
        "private": false,
        "fork": false,
        "parent": null,
        "empty": false,
        "mirror": false,
        "size": 608256,
        "html_url": "http://localhost:3000/githubs/flask_microblog",
        "ssh_url": "git@localhost:githubs/flask_microblog.git",
        "clone_url": "http://localhost:3000/githubs/flask_microblog.git",
        "website": "",
        "stars_count": 0,
        "forks_count": 0,
        "watchers_count": 3,
        "open_issues_count": 0,
        "default_branch": "master",
        "created_at": "2021-03-20T16:00:15Z",
        "updated_at": "2021-03-20T16:01:02Z",
        "permissions": {
            "admin": true,
            "push": true,
            "pull": true
        }
    }
]

```


### /api/v1/repos/migrate
该命令可以把github的仓库导入到gogs

```
curl --location --request POST 'localhost:3000/api/v1/repos/migrate' --header 'Authorization:  token ce55c8bb682f4ec5ea61f2d9423ba' --header 'Content-Type: application/json' --header 'Cookie: lang=en-US; i_like_gogs=feab5cd925f7; _csrf=ss9kUyQmC8CLgMFVZh3ITYzNjcwMAk2OTY4MjYB7MocU6MQyNzk2OD' --data-raw '{
    "clone_addr": "https://github.com/kelseyhightower/nocode",
    "uid": 2,
    "repo_name": "nocode",
    "mirror": false,
    "private": false,
    "description": "description werwer"
}'
```

```
{"message":"clone: exit status 128 - fatal: unable to access 'https://github.com/kelseyhightower/nocode/': OpenSSL SSL_read: No error information\n","url":"https://github.com/gogs/docs-api"}
```
这种情况是网络错误。
