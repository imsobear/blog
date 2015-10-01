---
layout: post
title:  "如何阻止 a 链接的默认行为"
date:   2015-05-04 11:47
published: false
---

阻止 `<a></a>` 的默认事件大概有以下方法：

## prevenDefault

```
<a href="#"></a>

a.on('click', function (e) {
    e.preventDefault();
    // 吧啦吧啦
});
```

## javascript:void(0)

我更喜欢使用这个方案，缺点是不支持 ie6, 不过现在已经不算问题了：

```
<a href="javascript:void(0)"></a>
```

不过，要注意，千万不要写成了 `<a href="javascript:void"></a>`, 这样的话，浏览器就会报错：

```
Uncaught SyntaxError: Unexpected end of input
```

这个错误很难定位，因为错误在 html 中，根本没有堆栈信息。

小伙伴推荐的另一种写法：`javascript:;`, 又短又好用。
 


