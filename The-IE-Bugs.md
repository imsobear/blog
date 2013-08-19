# IE下的BUG君们

### 1. overflow-x:
在IE6、7中，给父元素设置了`overflow: hidden;`，这时候如果子元素设置了`position`属性，则隐藏滚动条会失效，解决方案就是给父元素设置`position: relative`:
```css
body{
    overflow: hidden;
    *position: relative;  /* IE hack */
}
child{
    position: relative;
}
```
