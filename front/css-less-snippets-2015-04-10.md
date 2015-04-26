# css/less snippets

- clearfix
- box-sizing
- font
- 重置chrome下输入框的默认样式


## `clearfix`

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

## `box-sizing`

```css
html {
  box-sizing: border-box;
}
*, *:before, *:after {
  box-sizing: inherit;
}
```

## `font`

```
body {
	font: 12px/1.5 tahoma, 'Helvetica-Neue', Helvetica, Arial, sans-serif;
}
```

## `重置chrome下输入框的默认样式`

```css
input, button, select, textarea{
    outline:none;
}
textarea{
    resize:none;
}
```
