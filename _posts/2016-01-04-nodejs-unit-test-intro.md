---
layout: post
title: "Node.js 单元测试介绍"
date:  2016-01-04 23:00
published: true
---

![](http://gtms02.alicdn.com/tps/i2/TB1zt5kKVXXXXaVapXX2AXZ8pXX-900-500.png)

> 原文刊登于 [淘宝前端团队 FED 博客](http://taobaofed.org/blog/2015/12/10/nodejs-unit-tests/)

故事是这样的：小明是一个前端工程师，近期因为个人兴趣以及工作上的需要，开始做 Node.js 相关的项目。一个多月过去了，小明基于 Koa 搭出了自己的第一个 Node.js web 应用，在这个过程中，小明也遇到了很多的问题：

- 如何在上线时保证代码完全没问题？
- 每次增加功能时如何保证之前的功能是可用的？
- 随着代码增多，没有勇气和信心去重构代码

面对以上这些问题，小明作为一个前端工程师，惯性思维就是每次部署前先在页面上到处点点，然而一个机智的程序员怎么能把大好时间浪费在这些重复劳动上呢，于是小明就去咨询了组里的 Node.js 大牛老王，话说大牛毕竟是大牛，只是高冷的回复了一句：「单元测试」。

于是小明果断去谷歌搜索了「Node.js 单元测试」，毫无意外，一大堆的介绍和教程文章，粗略读了这些文章之后，小明得出了一些关于 Node.js 单元测试的结论，整理如下：

### 单元测试类型

单元测试分为 TDD（测试驱动开发）和 BDD（行为驱动开发）两种类型，对于这两种类型的比较，小明看的也是云里雾里，感觉单是介绍 TDD 和 BDD 就可以写两篇论文了。不过，选择哪种类型不还是得看代码怎么写嘛，于是小明对比了两种类型的代码：

```javascript
// TDD
suite('Array', function() {
  setup(function() {
  });

  test('should return -1 when not present', function() {
    assert.equal(-1, [1,2,3].indexOf(4));
  });
});

// BDD
describe('Array', function() {
  before(function() {
  });

  it('should return -1 when not present', function() {
    [1,2,3].indexOf(4).should.equal(-1);
  });
});
```

在对比了两种类型的语法之后，小明毫不犹豫的选择了 BDD，因为 BDD 的语法更加符合人类的思考方式，或者更加语义一点。

### 单元测试框架

**测试框架的职责即提供一套 API 帮助开发者更方便的测试代码**。在  JavaScript 社区有两个比较成熟的单元测试框架：jasmine 和 Mocha, 聚焦到 Node.js 社区的话，诸如 koa, express 等多数开源项目使用的都是 Mocha. 小明自然是打开 Mocha 的官网探个究竟，不看不知道，一看吓一跳：

![](http://gtms03.alicdn.com/tps/i3/TB1ui9kKVXXXXc0XFXXmree8pXX-867-595.png)

TDD/BDD 语法，异步方法测试，单测前置后置的 hook 等等，堪称完美。来一个简单的示例吧：

```javascript
var User = require('./models/user');

describe('models/user', function() {

  before(function(done) {
    User.new({name: '小明'}, done);
  });

  after(function(done) {
    User.delete({name: '小明'}, done);
  })

  it('should return an Object when find by name="小明"', function(done) {
    User.find({name: '小明'}, function(err, user) {
      if (err) {
        return done(err);
      }
      user.should.be.an.Object;
      user.name.should.equal('小明');
      done();
    });
  });
});
```

如上示例：首先在执行单测前通过 Mocha 的 before hook 向数据库里添加了一条测试数据，然后测试了 `User.find` 方法，最后通过 after hook 将这条测试数据删除。这里展示了 Mocha 的 hook 以及测试异步方法，更多的特性小明后续会详细的一一道来。

### 断言库

断言库即提供一套 API 帮助开发者在单元测试的过程中判定某个值是否符合预期，比如：

```javascript
// 以 should.js 为例
value.should.equal(1);
value.should.be.an.Object;
value.should.startWith('http://');
```

小明从 Mocha 的官网了解到：Mocha 为了保持自身的灵活性，因此默认不提供断言的 API。因此在 Mocha 中你可以使用各种各样的断言库，小明也顺便简单对比了下几种常用断言库：

断言库|优点|缺点|备注
-----|----|----|---
Node.js 核心库 Assert|无需第三方依赖|语法较弱|-
Should.js|API 非常语义|文档太烂|-
expect.js|-|-|比较中庸
chai|大而全的 API|-|

然后小明也简单对比了这几种断言库的语法：

```javascript
// assert
assert.equal(value, 1);

// should
value.should.equal(1);
value.should.be.a.Number;

// expect
expect(1).to.equal(1);
expect(value).to.be.a('number');
```

从功能上来讲，并无太大的优劣差别，不过写 Should.js 感觉就像写英文语句一般，非常流畅，甚至可以让产品经理也可以时不时来写几行测试代码。小明心想：对于一个程序员来讲，如果有一天可以站在旁边看着产品经理写代码，这种感觉想想都觉得爽。于是小明就暂时选定了 Should.js 作为项目的断言库。

我们都知道小明现在遇到的场景还很简单，只是判断类型啊、值是否相等啊，未来他还会碰到更复杂的场景比如：函数应该抛异常，`null/NaN/undefined` 的判断……随着踩的坑越多，相信小明也会带来更多的分享。

### 覆盖率

既然是给功能代码写单元测试，那就应该有个指标去衡量单元测试覆盖了哪些功能代码，这就是接下来要介绍的测试覆盖率。

在 Node.js 中，我们使用 istanbul 作为覆盖率统计的工具，istanbul 可以帮助我们统计到代码的语句覆盖率、分支覆盖率、函数覆盖率以及行覆盖率，生成的报告如下：

![](http://gtms03.alicdn.com/tps/i3/TB1GdiCKVXXXXcdXXXXbKaA3FXX-749-232.png)

小明不禁感叹：「这真是装逼利器啊」。

### 总结

了解了上面的这一堆概念之后，小明算是对单元测试有了一个初步的认识，同时也觉得单元测试的确是可以解决他在项目里遇到的那些问题。这时候你可能会说：

> Talk is cheap. Show me the code.

各位切莫着急，待小明实践之后，再来分享一二。

### 相关链接

- [Mocha](http://mochajs.org/)
- [Node.js Assert](https://nodejs.org/api/assert.html), [should.js](http://shouldjs.github.io/), [chai](http://chaijs.com/)
- [istanbul](https://github.com/gotwarlost/istanbul)












