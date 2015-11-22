---
layout: post
title:  "nginx 知识汇总"
date:   2015-04-24 9:00:01
published: false
---

nginx 的配置文件以及常用的命令等。

## 常用命令：

- 配置文件地址

    Mac: `/usr/local/etc/nginx/nginx.conf`
    Linux: `/etc/nginx/nginx.conf`

- 测试配置文件是否 OK: `nginx -t`
- 停止/重启：`nginx -s stop/reload`


## 常见问题：

### 执行重启命令时报 pid 的错误

参考：http://stackoverflow.com/questions/7646972/nginx-invalid-pid-number

执行 `sudo nginx -c /usr/local/etc/nginx/nginx.conf` 直接启动即可。

## 配置多个子域：

```
{
    # uitest client
     server {
        listen 80;
        server_name blog.sobear.me;
        location / {
            proxy_set_header Host $host:80;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Via "nginx";
            proxy_pass http://blog.sobear.me:3000;
        }
    }
     # uitest server
     server {
        listen 80;
        server_name xxx.sobear.me;

        location / {
            proxy_set_header Host $host:80;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Via "nginx";
            proxy_pass http://xxx.sobear.me:9090;
        }
    }
}
```


