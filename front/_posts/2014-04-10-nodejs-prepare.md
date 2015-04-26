---
layout: post
title:  "nodejs 环境准备"
date:   2015-04-10 21:43:01
---

## nvm

```
curl https://raw.githubusercontent.com/cnpm/nvm/master/install.sh | bash
// or
git clone https://github.com/cnpm/nvm.git
// or
git clone http://gitlab.alibaba-inc.com/node/nvm.git

// add to .bashrc or .zshrc
source ~/.nvm/nvm.sh

nvm install iojs-v1.6.1
nvm alias default iojs-v1.6.1
```


<!-- more -->

## cnpm & tnpm

```
// cnpm：国内用户
npm install -g cnpm --registry=https://registry.npm.taobao.org

// tnpm: 公司内部
npm install -g tnpm --registry=http://registry.npm.alibaba-inc.com
```
