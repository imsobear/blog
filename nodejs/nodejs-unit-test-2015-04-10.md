# node 单元测试


### nodejs 测试模块的私有方法：

如下代码：

```js
// helper

exports.parse = function () {

};

function privateMethod () {

}
```

对于 `helper.parse` 方法我们很容易写单元测试：

```js
// helper.test.js
var helper = require('lib/helper');

describe('lib/helper.js', function () {
    it('helper.parse', function () {
        hepler.parse().should...
    });
});
```

但是对于 `privateMethod` 我们无法直接通过 `helper` 这个对象访问，这时候就要使用 `rewire` 这个模块把私有方法暴露出来：

```
npm install rewire --save
```

```js
// helper.test.js
var rewire = require('rewire');
var helper = rewire('../lib/helper');

describe('lib/helper.js', function () {
    it('helper.parse', function () {
        helper.__get__('privateMethod').should...
    });
});
```

更详细的分析参见：[使用 “rewire” 获取模块的私有方法](https://github.com/fool2fish/blog/issues/1)



### 用 should 测试 `throw err` 的情况：

```js
(function () {
    helper.validateConfig(cfg);
}).should.throw();

// or

helper.validateConfig.should.throw();
```

### 用 should 测试没有抛错的情况

```js
fs.remove(buildFile, function (err) {
    should.not.exist(err);
	done();
});

// or

fs.remove(buildFile, function (err) {
    if (err) done(err);
	done();
});
```



