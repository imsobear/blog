---
layout: post
title:  "如何编译 less/stylus 中 import 的 css"
date:   2015-04-10 21:43:01
---

假设有这样一段代码：

```css
/* index.styl */

@import './header.css'

body {
    color: black;
}
```

那执行 `stylus index.styl > index.css` 编译后会生成这样的 `index.css`:

<!-- more -->

```css
@import './header.css'

body {
    color: black;
}
```

注意，`@import './header.css'` 会原封不动的 copy 过去，但是某种需求下我是希望直接将 css 的内容 copy 过去的，stylus 提供的方式是加参数：

```
stylus index.styl > index.css --include-css
```

对于同样的问题，`less` 是如何解决的呢：

```css
/* index.less */
@import (inline) './header.css'
```

用 inline 这个参数来声明即可，然后运行：`lessc index.less`, 当然这里的 inline 参数也可以是其他，参看末尾的相关链接。

### 注意事项：

OS X 或者 linux 系统有个系统命令叫 `less`, 所以不要搞混了哦，我们上文说的 less 对应的命令是 **`lessc`**.

```bash
npm i -g less
lessc index.less
```

### 参考链接：

- [less import option](http://lesscss.org/features/#import-options)
- [stylus --include-css(网页搜索即可)](http://learnboost.github.io/stylus/docs/executable.html)
