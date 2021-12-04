# hacdias webdav

[https://github.com/hacdias/webdav](https://github.com/hacdias/webdav)

# webdav

[![Build](https://github.com/hacdias/webdav/workflows/Tests/badge.svg)](https://github.com/hacdias/webdav/workflows/Tests/badge.svg) [![Go Report Card](https://camo.githubusercontent.com/8a41f4ce798f1860d088d185976edfa66e1cda65f85b679ae549e29dea51fc20/68747470733a2f2f676f7265706f7274636172642e636f6d2f62616467652f6769746875622e636f6d2f686163646961732f7765626461763f7374796c653d666c61742d737175617265)](https://goreportcard.com/report/hacdias/webdav) [![Version](https://camo.githubusercontent.com/8dc649692b70eeab7d07219be4cf51035a6ea716aa50d9705dac4b30d2700901/68747470733a2f2f696d672e736869656c64732e696f2f6769746875622f72656c656173652f686163646961732f7765626461762e7376673f7374796c653d666c61742d737175617265)](https://github.com/hacdias/webdav/releases/latest) [![Docker Pulls](https://camo.githubusercontent.com/32b8712b4099e2e4ab73d06907a1f006422315e5770217254958e7e757f1659b/68747470733a2f2f696d672e736869656c64732e696f2f646f636b65722f70756c6c732f686163646961732f776562646176)](https://hub.docker.com/r/hacdias/webdav)

## 

## Install

Please refer to the [Releases page](https://github.com/hacdias/webdav/releases) for more information. There, you can either download the binaries or find the Docker commands to install WebDAV.

## 

## Usage

`webdav` command line interface is really easy  to use so you can easily create a WebDAV server for your own user. By  default, it runs on a random free port and supports JSON, YAML and TOML  configuration. An example of a YAML configuration with the default  configurations:

```
# Server related settings
address: 0.0.0.0
port: 0
auth: true
tls: false
cert: cert.pem
key: key.pem
prefix: /

# Default user settings (will be merged)
scope: .
modify: true
rules: []

# CORS configuration
cors:
  enabled: true
  credentials: true
  allowed_headers:
    - Depth
  allowed_hosts:
    - http://localhost:8080
  allowed_methods:
    - GET
  exposed_headers:
    - Content-Length
    - Content-Range

users:
  - username: admin
    password: admin
    scope: /a/different/path
  - username: encrypted
    password: "{bcrypt}$2y$10$zEP6oofmXFeHaeMfBNLnP.DO8m.H.Mwhd24/TOX2MWLxAExXi4qgi"
  - username: "{env}ENV_USERNAME"
    password: "{env}ENV_PASSWORD"
  - username: basic
    password: basic
    modify:   false
    rules:
      - regex: false
        allow: false
        path: /some/file
      - path: /public/access/
        modify: true
```

There are more ways to customize how you run WebDAV through flags and environment variables. Please run `webdav --help` for more information on that.

### 

### Systemd

An example of how to use this with `systemd` is on [webdav.service.example](https://github.com/hacdias/webdav/blob/master/webdav.service.example).

### 

### CORS

The `allowed_*` properties are optional, the default value for each of them will be `*`. `exposed_headers` is optional as well, but is not set if not defined. Setting `credentials` to `true` will allow you to:

1. Use `withCredentials = true` in javascript.
2. Use the `username:password@host` syntax.

### 

### Reverse Proxy Service

When you use a reverse proxy implementation like `Nginx` or `Apache`, please note the following fields to avoid causing `502` errors

```
location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header REMOTE-HOST $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_redirect off;
    }
```

## 

## License

MIT © [Henrique Dias](https://hacdias.com)