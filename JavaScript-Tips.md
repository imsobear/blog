### 1. 扩展内置对象的原型时：

一般情况，尽量不要打`猴子补丁`，如有需要，最好按照下面的格式：
``` javascript
//Object可以是Array String Object Function等
if(typeof Object.prototype.method !== "undefined") {
  Object.prototype.method = function() {
    //方法代码
  }
}
```

### 2. 当以`new`操作符调用构造函数时，发生了：
* 创建一个空对象并且this变量引用了该对象，同时还继承了该函数的原型。
* 属性和方法被加入到this引用的对象中。
* 新创建的对象由this所引用，并且最后隐式的返回this(如果没有显示的返回其他对象)。



