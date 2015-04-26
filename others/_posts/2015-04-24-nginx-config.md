---
layout: post
title:  "nginx 常用配置"
date:   2015-04-24 9:00:01
---

nginx 的配置文件以及常用的命令等。

<!-- more -->

## 常用命令：

- 配置文件地址

    Mac: `/usr/local/etc/nginx/nginx.conf`
    Linux: `/etc/nginx/nginx.conf`

- 测试配置文件是否 OK: `nginx -t`
- 启动/停止/重启：`nginx -s start/stop/reload`

## 配置多个子域：

```
{
    # uitest client
     server {
        listen 80;
        server_name uitest.taobao.net;
        location / {
            proxy_set_header Host $host:80;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Via "nginx";
            proxy_pass http://uitest.taobao.net:3000;
        }
    }
     # uitest server
     server {
        listen 80;
        server_name server.uitest.taobao.net;

        location / {
            proxy_set_header Host $host:80;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Via "nginx";
            proxy_pass http://server.uitest.taobao.net:9090;
        }
    }
}
```


