# nodejs


# nodejs 环境准备


## `nvm`

```
curl https://raw.githubusercontent.com/cnpm/nvm/master/install.sh | bash

// 或者
git clone https://github.com/cnpm/nvm.git
// or
git clone http://gitlab.alibaba-inc.com/node/nvm.git

// add to .bashrc or .zshrc
source ~/.nvm/nvm.sh
nvm use 0.12.0
```

## `cnpm & tnpm`

```
// cnpm：国内用户
npm install -g cnpm --registry=https://registry.npm.taobao.org

// tnpm: 公司内部
npm install -g tnpm --registry=http://registry.npm.alibaba-inc.com
```
