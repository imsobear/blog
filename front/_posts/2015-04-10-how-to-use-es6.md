---
layout: post
title:  "现在就来使用 ES6"
date:   2015-04-10 21:43:01
published: true
---

## ES6 简介

ES3 -> ES5

ES4 ->  ES6

2015年6月会发布正式标准

## 令人兴奋的特点

### `let and const`

### `arrow function`

### `模板字符串`

### `函数默认参数`

### ` object method and property value shorthand`


## How


## `babel`

```
cnpm i babel --save-dev
```

### nodejs

```
node_modules/.bin/babel-node app.js
```


### nodemon

```
nodemon({
    script: 'app.js',
    execMap: {
        js: "node_modules/.bin/babel-node"
    },
    ignore: ['./test', './node_modules']
});
```

### mocha

```
NODE_ENV=test ./node_modules/.bin/mocha --compilers js:babel/register
```

### pm2

I dont't know

```
pm2 start app.js --interpreter ./node_modules/.bin/babel-node
```

- React
- `gulp-babel`


## Ref:

- [Airbnb JavaScript Style Guide()](https://github.com/airbnb/javascript/tree/es6)
- [ECMAScript 6 入门](http://es6.ruanyifeng.com/#docs/intro)
- [透过ES6看JS未来](http://johnhax.net/2014/es6-js-future/)
