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

## 特点

### `let and const`

#### 特点

- let 和 const, 都支持块级作用域
- const 用来声明常量，不能改变
- 不可重复声明
- 不存在变量声明提升

```
function go () {
  console.log(foo); 
  let foo = 2;
}
go(); // ReferenceError: foo is not defined
function go () {
  console.log(foo);
  var foo = 2;
}
go(); // undefined
```

const 声明的对象，地址不可变，但对象可变：

```
const foo = {};

foo.bar = 'foo'; // it's ok
foo = {}; // not use

const a = [];
a.push('Hello'); // ok
a = ["Dave"];    // not use
```

#### 心得

- 能用 const 就用 const, 不能用 const 了再用 let, 坚决不用 var
- 出乎意料：偶尔会用一下 let

### `arrow function`

#### 特点：

- 不会改变 this 指向

#### 心得：

- `var self = this`, 见鬼去吧

```
var foo = {

  nums: [1, 2, 3],

  addOne(num) {
    return num + 1;
  },

  go: {
    this.nums.forEach((num) => {
      console.log(this.addOne(num));
    });
  }

};

foo.go(); // 2,3,4
```

### `模板字符串`

### `函数默认参数`

### ` object method and property value shorthand`


## How

### iojs

iojs 2.0.0

支持的 ES6 特性：

### `babel`

```
tnpm i babel --save-dev
```

babel 基本支持了所有特性，缺点是：

- 生产环境下不够稳定

#### nodejs + babel

```
node_modules/.bin/babel-node app.js
```

#### nodemon + babel

本地调试时使用 nodemon:

```
nodemon({
    script: 'app.js',
    execMap: {
        js: "node_modules/.bin/babel-node"
    },
    ignore: ['./test', './node_modules']
});
```

#### mocha + babel

用 mocha 测试 ES6 的代码：

```
NODE_ENV=test ./node_modules/.bin/mocha --compilers js:babel/register
```

#### pm2 + babel

生产环境使用 pm2:

```
pm2 start app.js --interpreter ./node_modules/.bin/babel-node
```

### 前端的 ES6

#### React

React 自带的编译工具支持 es6

#### gulp-babel

```
var gulp = require('gulp');
var babel = require('gulp-babel');
 
gulp.task('default', function () {
    return gulp.src('src/app.js')
        .pipe(babel())
        .pipe(gulp.dest('dist'));
});
```

gulp-babel: https://www.npmjs.com/package/gulp-babel


## Ref:

- [Airbnb JavaScript Style Guide()](https://github.com/airbnb/javascript/tree/es6)
- [ECMAScript 6 入门](http://es6.ruanyifeng.com/#docs/intro)
- [透过ES6看JS未来](http://johnhax.net/2014/es6-js-future/)
