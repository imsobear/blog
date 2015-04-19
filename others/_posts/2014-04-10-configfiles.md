---
layout: post
title:  "常用配置文件"
date:   2015-04-10 21:43:01
---


## .gitignore

```
.idea
node_modules
npm-debug.log
.DS_Store
coverage
```

## .editorconfig

```
root = true

[*.js]
indent_style = tab
indent_size = 2
```

## .eslintrc

```
{
  "env": {
    "browser": true,
    "node": true,
    "es6": true,
    "mocha": true,
    "jquery": true,
    "amd": true
  },
  "ecmaFeatures": {
    "jsx": true,
    "genetator": true
  },
  "globals": {
    "KISSY": true,
    "React": true
  },
  "rules": {
    "eqeqeq": 1,
    "quotes": [1, "single"],
    "strict": 0
  }
}
```


## ~/.ssh/config

```bash
Host github.com
  HostName github.com
  User imsobear
  IdentityFile ~/.ssh/id_rsa_github

Host gitlab.alibaba-inc.com
  HostName gitlab.alibaba-inc.com
  User 大果
  IdentityFile ~/.ssh/id_rsa
```

## .git/config

```
[user]
    email = sobear.me@gmail.com
    name = imsobear
```
