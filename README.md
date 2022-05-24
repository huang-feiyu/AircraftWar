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
├── addons/
│   └── godot_table/
├── assets/
│   ├── audio/
│   ├── fonts/
│   └── img/
├── src/
│   ├── Main.gd
│   ├── Main.tscn
│   ├── characters/
│   │   ├── FlyingObject.gd
│   │   ├── bullets/
│   │   ├── enemies/
│   │   ├── hero/
│   │   └── props/
│   ├── models/
│   │   ├── dao/
│   │   ├── game/
│   │   └── ui/
│   └── tools/
│       ├── DifficultyManager.gd
│       └── GameManager.gd
└── project.godot
 ```

## 优化日志

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

### 2022-05-18

1. 子弹撞墙反弹

创建一个子弹基类 `BaseBullet` 重写 `move` 方法.

2. 直射子弹有尾巴

改为水平发射.

### 2022-05-19

1. Restart 后不产生 boss

`GameManager` 中需要一个初始化方法.

### 2022-05-24

0. 测试 Node 是否能够继承

可以, 增加继承层级.

1. 游戏属性管理过于分散



## 实现日志

> 已实现基本功能.

### 2022-05-18

实现排行榜. 对于数据存储模式, 准备采用 [SQLite](https://github.com/2shady4u/godot-sqlite), 此次还不予实现.

```
# select by difficulty
Rank | Name | Score | Date |
```

