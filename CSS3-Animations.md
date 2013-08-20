# CSS3 Animation有关

目前，IE10+以及火狐、webkit支持该属性，并且IE和火狐已不需要前缀，只有chrome和safari需要webkit前缀。
### 1. animation参数说明：
```css
.anim{
     animation: name duration timing-function delay iteration-count direction play-state;
}
```
* `duration`: 动画执行时间，默认为0；
* `timing-function`: 动画速率控制，默认为ease:
     - linear: 速率相同；
     - ease: 默认值，快-慢-快；
     - ease-in: 慢-快；
     - ease-out: 快-慢；
     - ease-in-out: 慢-快-慢。
* `delay`: 动画延时，默认为0；
* `count`: 动画重复次数，默认为1，设置为`infinite`表示无限重复；
* `direction`: 播放方向：
     - normal: 默认值，正常播放；
     - reverse: 反向播放；
     - alternate: 先正向再反向；
     - alternate-reverse: 先反向再正向。
* `state`: 控制动画播放暂停：
     - running: 默认；
     - paused: 暂停动画；
