---
layout: post
title:  "css/less snippets"
date:   2015-04-10 21:43:01
published: false
---

- clearfix
- box-sizing
- font
- 重置chrome下输入框的默认样式

##

```css
.list-wrapper {
  overflow-x: scroll;
  // 滚动更平滑
  -webkit-overflow-scrolling: touch;
  // 隐藏滚动条
  &::-webkit-scrollbar{
    display: none;
  }
}
```

## clearfix

```css
.cf:before, .cf:after {
    content:"";
    display:table;
}
.cf:after {
    clear:both;
}
.cf {
    zoom:1;
}
```

<!-- more -->

## box-sizing

```css
html {
  box-sizing: border-box;
}
*, *:before, *:after {
  box-sizing: inherit;
}
```

## font

```
body {
	font: 12px/1.5 tahoma, 'Helvetica-Neue', Helvetica, Arial, sans-serif;
}
```

## 重置chrome下输入框的默认样式

```css
input, button, select, textarea{
    outline:none;
}
textarea{
    resize:none;
}
```

