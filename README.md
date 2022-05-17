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
├── src
│   ├── characters
│   │   ├── bullets
│   │   ├── enemies
│   │   ├── hero
│   │   └── props
│   └── models
│       ├── game
│       └── ui
└── project.godot
```

## 优化记录

### 2022-05-17

已实现基本的单机功能, 但是各类型之间十分不统一, 需要进一步优化.

1. 敌人之间存在类似行为, 可以考虑将其合并.

trade-off: script or scene
* 如果希望创建一个基本工具, 它将在几个不同的项目中重用, 以及可能提供给不同技能水平的人使用.(包括那些不认为自己是个程序员的用户), 它很可能是一个脚本, 有一个自定义名称/图标.
* 如果有人想创造一个特定于他们的游戏的概念, 那么它应该是一个场景. 场景比脚本更容易跟踪/编辑, 并提供更多的安全性.

此时更好的方法是创建一个 scene `Enemy`, 各敌人类型都应该继承此类.

```java
Mob extends Enemy
Elite extends Enemy
Boss extends Enemy
```

2. 基础类之间存在类似行为, 可以考虑将其合并.

过度的继承会导致项目耦合性过强, 并且不利于维护, 故仅进行非常简单的继承.

```java
HeroBullet, EnemyBullet extends FlyingObject
Blood, Bullet, Bomb extends FlyingObject
Enemy extends FlyingObject
```

3. 



















