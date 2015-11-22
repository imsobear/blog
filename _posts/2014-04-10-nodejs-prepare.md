---
layout: post
title:  "Nodejs 环境配置终极解决方案"
date:   2015-04-10 21:43:01
---

工欲善其事，必先利其器。

## nvm 管理 Nodejs 版本

```
curl https://raw.githubusercontent.com/cnpm/nvm/master/install.sh | bash

// add to .bashrc or .zshrc
source ~/.nvm/nvm.sh

nvm install iojs-v3.0.0
nvm alias default iojs-v3.0.0
```

## cnpm/tnpm 加速 npm

```
// cnpm：国内用户
npm install -g cnpm --registry=https://registry.npm.taobao.org

// tnpm: 公司内部
npm install -g tnpm --registry=xxxx
```

## 不同版本的 Nodejs 共享全局的 npm

用 nvm 管理 node 版本，会碰到这样一个问题：对于各个版本的全局 npm 模块，是各自独立的，因此，当你在 0.12.6 下全局安装了某个模块，然后切换到 0.12.7 之后又得重新安装。所以，解法就是 npm prefix

```
// 获取当前的 prefix
npm config get prefix   // ~/.nvm/versions/0.12.6/...

// 将 prefix 设置到一个全局目录下，比如新建一个 /Users/guo/npm-global, 这个文件不要放在需要 sudo 的文件夹下
npm config set prefix /Users/guo/npm-global
```

设置之后，再用 npm 安装全局模块时就会放在 npm-global 下，注意 **npm/cnpm 的 prefix 是各自独立的，因此每个都需要设置一下**。

然后呢，全局模块的可执行文件也会放在 `npm-global/bin` 目录下，想要执行这些命令的话，还需要添加一条 PATH, 打开你的 `.zshrc` 或者 `.bashrc`, 末尾添加一行：

```
export PATH=/Users/guo/npm-global/bin:$PATH
```

搞定！

