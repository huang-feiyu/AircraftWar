# Aircraft War

> 本文档记录 project architecture & spec.

通过 [Godot Engine](https://godotengine.org/) 实现, 导出到安卓 APK 即可使用.

[TOC]

## 项目结构

> 大致遵循官方的 [project organization](https://docs.godotengine.org/zh_CN/stable/tutorials/best_practices/project_organization.html) 指南.

### 游戏流程图

```
Main(S0), ChooseModeHUD --{5}-> Main, LoginHUD --{4}-> $$ -- Main, MessageHUD --{1}-> Game, PlayHUD(S1) --{2}-> RankList, MessageHUD(S2) --{3}-> S0

Main(S0), ChooseModeHUD {0}
│
├─ Single -> Main/LoginHUD -{1}-> Main/MessageHUD(S1) -{2}
│                                                       │
│                                                       └--> Game/PlayHUD --{3}-> RankList, MessageHUD(S2)
│
└─ Match  -> WebMain/WebLoginHUD -{1}-> WebMain/FindMatch
                                        │
                                        {4}-> WebMain/ReadyScreen -{5}-> S1

{0}: 单机或者网络游戏
{1}: 登录校验/注册
{2}: 开始游戏, 根据 MessageHUD 中 Button 的状态切换到不同的难度.
{3}: 游戏结束, 自动切换到 S2.
    * if single: 切换到排行榜, 根据 MessageHUD 中 RestartButton 切换到 S0.
    * if match: 等待两者都结束, 显示分数对比与输赢. 根据 MessageHUD 中 RestartButton 切换到 S0.
{4}: 等待玩家匹配, 匹配完成后, 切换到 ReadyScreen.
{5}: 等待玩家确认, 玩家都确认后, 切换到 S1.
```

### 目录结构

```tree
.
├── LICENSE
├── README.md
├── addons/ 第三方库
├── assets/ 素材资源
├── data/ 测试数据
├── src/ 游戏代码
│   ├── Main.gd
│   ├── Main.tscn
│   ├── characters/
│   │   ├── FlyingObject.gd
│   │   ├── FlyingObject.tscn
│   │   ├── bullets/
│   │   ├── enemies/
│   │   ├── hero/
│   │   └── props/
│   ├── models/
│   │   ├── dao/
│   │   ├── game/
│   │   ├── login/
│   │   └── ui/
│   ├── online
│   │   ├── WebMain.gd
│   │   ├── WebMain.tscn
│   │   ├── autoload
│   │   └── ui
│   └── tools/
│       ├── GameManager.gd
│       └── GameManager.tscn
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

1. 英雄类内部结构混乱

删去冗余的属性.

2. 修改其他冗余

### 2022-05-31

1. 修改单机登陆界面 UI

2. 适配 Window Dialog 字体

### 2022-06-10

todo: 结构混乱, 需要做一些优化.
