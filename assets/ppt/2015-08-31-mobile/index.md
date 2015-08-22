title: 商盟无线项目总结
speaker: 大果

[slide style="background-image:url('/img/2.JPG')"]

# 商盟无线项目总结

> 一次完整的无线开发之旅

------

大果, 2015.08.21

[slide style="background-image:url('/img/2.JPG')"]

# 大纲

------

- 适配
- 调试
- 工具链/工程化
- 项目实战经验
- 吐槽

[slide style="background-image:url('/img/2.JPG')"]

# 适配

[slide style="background-image:url('/img/2.JPG')"]

## mbase

--------

- 动态设置 meta 标签
- 设置 html 的 `font-size` 为 `width/10 px`
- 使用方法：

```less
@rem: 75rem;

body {
  width: 750/@rem;
  margin-left: 15/@rem;
}
```

[slide style="background-image:url('/img/2.JPG')"]

## 一切皆 rem?

- 优点：方案简单统一，基本无需考虑适配问题
- 缺点：小屏幕上（如 iphone5）字会很小

## 所以？

- 适配方案：**文字流式**，控件弹性，图片等比缩放，[如图所示](http://gtms03.alicdn.com/tps/i3/TB1YyWJJXXXXXXEapXXl1MM.FXX-560-720.png)
- 然而：对于前端来讲，如果前期没考虑到，中途修改成本较高

[slide style="background-image:url('/img/2.JPG')"]

## 奇葩的适配问题

- `1 rem != 1 html font-size`（中兴、MX4），[事故现场](http://k3.alibaba-inc.com/issue/6183751?versionId=1194023&companyId=0&toPage=2)

## 怎么解决？

- 对于特定机型，动态放大 html 的 `font-size`

    ```javascript
    if(/ZTE U930_TD/.test(navigator.userAgent)) {
        win.rem = win.rem * 1.13;
    }
    ```

- 不去理会，不建议在这种奇葩问题上浪费时间

[slide style="background-image:url('/img/2.JPG')"]

# 调试

[slide style="background-image:url('/img/2.JPG')"]

## chrome 原生工具

- 优点：使用简单
- 缺点：
  - 跟真机有一定差异
  - 对于依赖 APP 的 bridge.js 情形无能为力 !important

[slide style="background-image:url('/img/2.JPG')"]

## chrome#inspect

- 安卓系统 4.0.x 
- 用手机浏览器打开的页面可直接调试，但是对于运营在 APP 的 webview 里的页面，需要 APP 本身打开 webview 调试功能

<br>

> 然，大多数情况下我们并不知道怎么打开 APP 的 webview 调试功能...

[slide style="background-image:url('/img/2.JPG')"]

## mds

- 基于 chrome#inspect, 使用起来更加方便
- 整合了阿里系的多数 APP, 很方便的可以打开 webview 调试功能
- 其他：调试 iOS 上的 safari、使用 iOS 模拟器，然并卵

[slide style="background-image:url('/img/2.JPG')"]

## weinre: 为了拯救 iOS

- 调试功能较弱，实属无奈之选
- 使用方法：
  + 引入 js: `http://weinre.alibaba.net/target/target-script-min.js#daguo`
  + 打开页面: `http://weinre.alibaba.net/client/#daguo`

[slide style="background-image:url('/img/2.JPG')"]

## 高阶玩法：

<img src="http://gtms02.alicdn.com/tps/i2/TB1axyUJXXXXXXMXVXXDPhh5VXX-970-429.png" style="height: 400px;position:relative">

最后，建议阅读：[各种真机远程调试方法汇总](https://github.com/jieyou/remote_inspect_web_on_real_device)

[slide style="background-image:url('/img/2.JPG')"]

# 工程化

[slide style="background-image:url('/img/2.JPG')"]

## 构建-发布

- 构建工具：
    - kimi-builder 内置了 [autoprefixer](https://www.npmjs.com/package/gulp-autoprefixer), css 中无需关心浏览器前缀
- awp 发布：
    - `def kimi awp`: 自动替换版本号，发布 page 下的 index.html 到对应的 awp 环境
    
    ```
    └── p
        ├── home
        │   ├── index.html
        │   ├── index.js
        │   ├── index.less
    ```

[slide style="background-image:url('/img/2.JPG')"]

## 数据接口

> dip 的作用并不明显

<br>

    - 影响效率：编辑新接口成本太高
    - 第一次使用后不会再维护，类似我们的 demo
    - 开发并没有那么听话 T_T

<br>

> 所以，dip 更适合应用在多人合作的大型项目中，如各种大促，单个业务里的确会增加成本

[slide style="background-image:url('/img/2.JPG')"]

## 质量

- 单元&集成测试
    - 没有成熟方便的方案，未来在 cake 里集成 knight.js
    - 没足够时间写单元测试
- 线上异常监控：jstracker
    - 无论后端还是前端，日志很重要，尤其是异常日志报警 
    - 计划下个版本接入

[slide style="background-image:url('/img/2.JPG')"]

# 项目经验

[slide style="background-image:url('/img/2.JPG')"]

## 前端也需要配置中心

- 当对接的服务较多时，把配置项抽离出来

<img src="http://gtms01.alicdn.com/tps/i1/TB1uL5IJXXXXXbxapXXVDKf5VXX-437-523.png" style="left:auto;top: 50px;right:-200px;width:60%;min-width:auto;min-height:auto;max-height:2000px !important;max-width:2000px !important;">

[slide style="background-image:url('/img/2.JPG')"]

## API: 统一管理，统一处理

<img src="http://gtms04.alicdn.com/tps/i4/TB1KLGQJXXXXXXzaXXXUXPiTVXX-520-660.png" style="left:auto;top:50px;right:-200px;width:60%;min-width:auto;min-height:auto;max-height:2000px !important;max-width:2000px !important;">

[slide style="background-image:url('/img/2.JPG')"]

## iconfont

- 无线端只需要 .ttf 格式
- 注意属性选择器：^= 真的是 ^=，可不会匹配 `class="home icon-home"`
- 自定义字体要加业务前缀，防止冲突

-------

```css
// mixin.less
@iconUrl: '//at.alicdn.com/t/font_1438226812_8743904.ttf';

@font-face {
  font-family: 'tsm-iconfont';
  src: url(@iconUrl) format('truetype');
}
.iconfont(@size: 12) {
  font-family: 'tsm-iconfont';
  font-size: unit(@size/@remScale, rem);;
  font-style: normal;
}

// base.less
[class^='icon-'] {
  .iconfont();
}
```

[slide style="background-image:url('/img/2.JPG')"]

# 单页面应用：静态资源加载方案

## 常规方案：

把所有静态资源打包的 app.js 和 app.css 里，一次加载，终身省事

## 缺陷：

app.js 过大，并且会引入一些无用的脚本和样式，比如说新人引导页面的静态资源，只有用户第一次使用才会用到

[slide style="background-image:url('/img/2.JPG')"]

# 单页面应用：静态资源加载方案

- 把主页面的静态资源打包在一起，如 tab 对应的：附近，消息，我的
- 其余页面，在切换时动态 use: 静态资源的版本号需要手动管理

<br>

```javascript
// app.js
var user = require('../pages/user/');
var near = require('../pages/near/');
var msg = require('../pages/msg/');
var contacts = require('../pages/contacts/');

// spa.js
var loadAssets = function(cb) {
    if (!page.obj) {
      TSM.loading();
      $.use(TSM.getPagePath(pageName), function(obj) {
        page.obj = obj;
        cb(obj);
      });
    } else {
      cb(page.obj);
    }
};
```

[slide style="background-image:url('/img/2.JPG')"]

> # 不能不吐的槽

<br>

前方负能量爆棚，请做好心理准备...

[slide style="background-image:url('/img/2.JPG')"]

## 我是如何被千牛折磨疯的？

<div class="page">
<p>请大声告诉我，h5 的优势是什么？跨！平！台！</p>
<p>然，在这个项目里，我至少有 5 次分别跟千牛的安卓和 iOS 工程师调试 API。</p>
<p>所以，我们为什么不去做个 APP？</p>
</div>

<br>

> 这只是其中一点！

<style>
.page p {
    line-height: 1.8;
    font-size: 20px;
    letter-spacing: 0;
    margin-bottom: 10px;
}
</style>

[slide style="background-image:url('/img/2.JPG')"]

## 什么是良好生态

- 完整可靠的文档
- 经过测试的，稳定可用的底层 API
- 调试方便开发爽

<br>

比如 npm, 比如 def, 然而...

[slide style="background-image:url('/img/2.JPG')"]

## 千牛都不是的！！！

- 完整可靠的文档  -> 我不遗余力的找到了不下五处的文档
- 经过测试的，稳定可用的公共 API  —> 谁用谁是小白鼠
- 调试方便开发爽  -> 在环境的配置上我花费了大量的时间

<br>

然而...

[slide style="background-image:url('/img/2.JPG')"]

> # 谁让你的应用要依赖那么多原生方法

[slide style="background-image:url('/img/2.JPG')"]

<img src="http://static.9you.com/uploadfile/gundamplay/04b3bdf56d23170a05e3ab3fac7da1f5.jpg" style="width:20%;height:20%; max-width: 2000px;max-height:2000px;position: relative;">

[slide style="background-image:url('/img/2.JPG')"]

## 所以

- 有没有可能做成这样一件事，阿里系的 APP，bridge 层面共享基础的 API，然后各个业务在这个基础上扩展。

<br>

```
|--Ali.bridge.js
|--Tao.bridge.js
|--Tmall.bridge.js
|--QN.bridge.js
|--...
```

<br>

> ### ?


[slide style="background-image:url('/img/2.JPG')"]

# 下期预告

- midway 123 @乔福
- 大西北之旅 @大果


<style>
h1 {
    font-size: 50px !important;
}
h2 {
    font-size: 40px !important;
}

    h1, h2 {
        margin: 20px 0;
    }

    slides>slide .slide-wrapper {
        text-align: left !important;
    }
    html * {
        letter-spacing: 0 !important;
    }
</style>