### 整理一些前端笔试题

========

#### 第一期

1. 在0级DOM事件模型，通过 onclick 属性来绑定事件，比如: dom.onclick = function(){}; 这个方式最大的缺点之一是每个元素上只能绑定一个事件监听函数。
请实现一个函数 click, 基于0级DOM事件模型实现，但是可以在一个元素上绑定多个事件监听函数，函数声明如下：
function click(element, callback) {…}
```javascript
    var elem = document.getElementById('test');

    click(elem, function() {
        console.log(1);
    })

    click(elem, function() {
        console.log(2);
    })

    elem.onclick = function() {
        for (var i = 0, l = elem.funcs.length; i < l; i++) {
            elem.funcs[i]();
        }
    };
    
    function click(elem, func) {
        if (elem.funcs === undefined) {
            elem.funcs = [];
        }
        elem.funcs.push(func);
    }
```


2. 实现一个字符串格式化函数，function format(str, obj)，将str中的 "#{name}"替换成 obj中对应的值。比如：
format("#{name} say: #{msg}", {name: 'Bob', msg: 'hello!'})
输出： "Bob say: hello!" 

    ```javascript
    // By 大果
    function format(str, datas) {
        var reg = /#{\w+}/g,
              matchs = str.match(reg);
        for (var i = 0, l = matchs.length; i < l; i++) {
              str = str.replace(new RegExp(matchs[i]), datas[matchs[i].slice(2, -1)]);
        }
        return str;
    }
    // By 岱浩
    function format2(str,obj){
        var reg = /#{(\w+)}/g,
              rep;
        while(rep = reg.exec(str)) {
            str = str.replace(rep[0],obj[rep[1]]);
        }
        return str;
    }
    ```

----------
#### 第二期

1. 以下两段代码有什么不同？

```javascript
setTimeout(function(){
/* 代码块... */ 
setTimeout(arguments.callee, 10); 
}, 10); 

setInterval(function(){ 
/*代码块... */ 
}, 10);
```
2. 判断字符串是否是这样组成的，第一个必须是字母，后面可以是字母、数字、下划线，总长度为5-20。
3. 实现 Array.prototype.forEach 方法。
4. 使用Javascript打印出1-10000之间的所有对称数（例如 121 1331等）。
5. 使用纯CSS实现未知尺寸的图片(但高宽都小于200px)在200px的正方形容器中水平和垂直居中。
