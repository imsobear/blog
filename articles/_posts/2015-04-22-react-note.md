---
layout: post
title:  "React 笔记"
date:   2015-04-22 14:43:01
---

## 为元素设置自定义属性：

参考：[自定义 HTML 属性](http://facebook.github.io/react/docs/jsx-gotchas-zh-CN.html#-html-)

可以设置 `data-*` 或者 `aria-*`, 注意不能大写，如：

```
// bad
<a data-buildId={buildId}>{build.buildTimes}</a>

// good
<a data-build-id={buildId}>{build.buildTimes}</a>
```
