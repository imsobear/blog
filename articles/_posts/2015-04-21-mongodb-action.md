---
layout: post
title:  "MongoDB 操作"
date:   2015-04-21 14:00:01
published: false
---

本文收录一些在 mongodb 里常用的操作，方便日后查询使用。

<!-- more -->

## 替换数组里的某个元素

```
db.projects.update({
    'builds.buildId': body.buildId,
}, {
    $set: {
        'updatedAt': Date(),
        // replace array element
        'builds.$': self.generateBuildData(body)
    }
});
```


## $push 和 $set 同时使用

```
db.projects.update({
    taskId: body.task_id
}, {
    $set: {
        updateAt: Date()
    },
    $push: {
        builds: self.generateBuildData(body)
    }
});
```
