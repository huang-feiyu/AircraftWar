# Aircraft War

> 本文档记录 project architecture & spec.

通过 [Godot Engine](https://godotengine.org/) 实现, 导出到安卓 APK 即可使用.

[TOC]

## 项目结构

> 大致遵循官方的 [project organization](https://docs.godotengine.org/zh_CN/stable/tutorials/best_practices/project_organization.html) 指南.

```tree
.
├── LICENSE
├── README.md
├── addons
├── assets
│   ├── audio
│   ├── fonts
│   └── img
└── src
    └── characters
        ├── bullets
        ├── enemies
        ├── hero
        └── props
```

## spec

### Hero

#### Methods

| method                 | args                           | desc                    |
| :--------------------- | :----------------------------- | :---------------------- |
| `_ready`               | `()`                           | 初始化英雄              |
| `_process`             | `(delta)`                      | 每帧处理                |
| `_on_Hero_input_event` | `(viewport, event, shape_idx)` | 触摸监测<br/>英雄机移动 |
| `_on_Hero_hit`         | `()`                           | 撞击监测                |

#### Attributes

| attribute | init  | max   | desc                      |
| :-------- | :---- | :---- | :------------------------ |
| hp        | 1000  | 1000  | 血量<br/>death if hp <= 0 |
| shoot_num | 1     | 7     | 射击的子弹数目            |
| power     | 30    | 50    | 子弹威力                  |
| is_dead   | false | false | 是否死亡                  |

### 
