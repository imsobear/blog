---
layout: post
title: " Node.js 单元测试之 workflow"
date:  2016-01-05 23:00
published: true
---

![](https://img.alicdn.com/tps/TB13keMLXXXXXbmXVXXXXXXXXXX-900-500.jpg)

> 原文刊登于 [淘宝前端团队 FED 博客](http://taobaofed.org/blog/2015/12/29/nodejs-unit-tests-workflow/)

-------------

> Talk is cheap, show me the code!

是否还记得小明在《Node.js 单元测试之我要写测试》里引用的这句话么，不过引用了之后，小明就像跑路了一般再也没见其 code……其实呀，不知道大家有没有关注最近比较火 minggeJs, 稍微联想下你就知道小明最近在忙啥了O(∩_∩)O~~

虽说小明现在还写不出 minggeJs 这样的前端库，不过，小明想说的是：**当你准备开源一个库的时候，一定要写单元测试；当你要使用一个开源库的时候，单元测试的覆盖率是衡量质量的最重要标准之一**。

好了，扯了这么多闲话之后，明哥（不对，是小明……）接下来介绍一下在项目里单元测试整个流程是如何的。

### Node.js 专属之 `npm scripts`

起初，小明将 Mocha 和 istanbul 装在全局命令下，然后每个项目都使用全局的命令，后来发现多人合作时会因为版本不一致而报错，因此果断将 Mocha 之类的装在项目的 `node_modules/` 下：

```
npm install mocha istanbul --save-dev
```

然后只需要执行下面两条命令即可：

```
# 执行单测
./node_modules/.bin/mocha test/*.test.js --timeout 20000
# 收集覆盖率报告
./node_modules/.bin/istanbul cover ./node_modules/.bin/_mocha -- -u exports --reporter spec --timeout 20000
```

然而每次都执行这么长的命令让隔壁（座位）的老王实在看不下去了，于是就告诉小明 `npm scripts` 的用法。只需要在 `package.json` 里定义几个命令即可：

```
"scripts": {
  "test": "./node_modules/.bin/mocha 'test/*.test.js' --timeout 20000",
  "cov": "./node_modules/.bin/istanbul cover ./node_modules/.bin/_mocha -- -u exports 'test/*.test.js' --timeout 20000"
}
```

如此之后，每次写完代码，小明只需要执行 `npm run test/cov` 即可，省事了很多。

不知道诸位有没有注意到，小明在 `'test/*.test.js'` 上故意加了一个引号，这一点也是小明被坑了之后才发现的：执行 shell 命令时，如果参数中包含如 `test/*.test.js` 这种 glob 模式，对应的 shell 会自动解析掉，但是不同的 shell 对 glob 的实现又不一致，因此就会出现匹配文件出错的问题，当加了引号之后，shell 会把参数原封不动的交给 Mocha（或者其他工具）来解析，这样才能保持不同 shell 的一致性。

当然，`npm scripts` 还有很多对于 Node.js 开发者很便利的功能，请参阅文末的相关链接。

### 构建利器 makefile

随着代码的积累，小明写的单测也越来越多，有时候可能只需要运行某一个测试文件，所以小明希望能通过命令行参数将需要测试的单个文件传进去，这时候 `npm scripts` 就显得捉襟见肘了。于是小明继续秉持着「有问题找老王」的原则，老王毫不犹豫的给小明推荐了 `makefile`.

关于 `makefile` 的介绍，网上有很多的资料，小明的简单理解就是：`makefile` 就是将某个流程（如编译、打包、构建等）包含的所有相关命令集成到一个 make 命令下，极大的方便开发者。具体到目前的场景，可以参照如下的示例：

```
test := './test/*.test.js'
timeout := 20000
mocha := ./node_modules/.bin/mocha
istanbul := ./node_modules/.bin/istanbul
coverageMocha := ./node_modules/.bin/_mocha

test:
    echo '开始运行单测'
    $(mocha) --timeout $(timeout) $(test)
    echo '单测运行结束'

cov:
    $(istanbul) cover $(coverageMocha) -- -u exports $(test) --timeout $(timeout)

# 区分命令和文件名称
.PHONY: test
```

在项目里定义了如上的 `makefile` 文件后，只需要执行 `make test` 就可以跑单元测试了，并且上面提到的传参数的问题也可以迎刃而解：`make test test=test/util.test.js`. 相对于 `npm scripts`, `makefile` 借助 shell 脚本的能力要强大灵活很多，然而一个不太好的消息是：windows 并不支持 `makefile`……

### 持续集成

在经过了上面的这些步骤之后，小明在本地已经可以完美的执行单元测试了，然而在跟小伙伴们合作的过程中，小明发现有的同学并不是很关注这个事情，单元测试没跑通过就将代码 push 到了远程仓库，这时候就需要其他同学来帮忙擦屁股，很是不方便。

于是，老王就告诉了小明持续集成这个东西，所谓持续集成，简单来讲就是：在代码 push 之后，对代码进行一系列的构建，比如 lint 检测、单元测试、部署等，借此提高代码的质量以及多人合作开发效率。而在 Node.js 领域，这方面比较优秀的工具就是 travis-ci 了，小明也顺便体验了一下 travis-ci, 按照其三步走的接入流程的确是非常之方便。

![](https://img.alicdn.com/tps/TB1LQm3LXXXXXbyXpXXXXXXXXXX-657-166.png)

然而，小明平时开发的仓库大部分都是托管在内部的，没法使用面向 github 的 travis-ci, 这一次小明决定不再去问老王了，程序员嘛，造轮子的功能还是要有的。于是，在一个多月的开发后，小明基于内部的其他服务做出了一个八九不离十的持续集成系统，名曰 UITest-ci:

![](https://img.alicdn.com/tps/TB1wgiRLXXXXXXmXVXXXXXXXXXX-1266-273.png)

这个系统可以运行单测、执行 lint、可以生成覆盖率报表、可以通知开发者集成结果、同时提供徽章服务，近乎完美。之后有时间了再详细介绍这个系统的设计和实现吧 :)

### 总结

至此，小明介绍了单元测试各个部分的相关概念以及整个工作流程是如何的，接下来，我们会面对项目中更具体的一些单测问题，比如：如何用 supertest 做接口测试、如何测试私有方法、如何针对命令行工具做单测等等。敬请期待~

### 相关链接

- [npm scripts 文档](https://docs.npmjs.com/misc/scripts)
- [跟我一起写 makefile](http://wiki.ubuntu.org.cn/%E8%B7%9F%E6%88%91%E4%B8%80%E8%B5%B7%E5%86%99Makefile)
- [持续集成：travis-ci](https://travis-ci.org/)
