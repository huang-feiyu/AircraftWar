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

```tree
Hero
├── AnimatedSprite
├── CollisionShape2D
├── BulletTimer
├── HeroBullet (通过 Timer 创建)
└── BulletSound
```

#### Attributes

| attribute | init  | max  | desc                             |
| :-------- | :---- | :--- | :------------------------------- |
| hp        | 1000  | 1000 | 血量<br/>is_dead=true if hp <= 0 |
| shoot_num | 1     | 7    | 射击的子弹数目                   |
| power     | 30    | 50   | 子弹威力                         |
| is_dead   | false | \\   | 是否死亡                         |

#### Methods

| method                    | args      | desc                       |
| :------------------------ | :-------- | :------------------------- |
| `start`                   | `(pos)`   | 初始化英雄<br/>TODO:       |
| `end`                     | `()`      | 英雄死亡处理<br/>TODO:     |
| `_ready`                  | `()`      | 预处理, nothing            |
| `_process`                | `(delta)` | 每帧处理, nothing          |
| `_input`                  | `(event)` | 触摸监测, 英雄机移动       |
| `_on_Hero_hit`            | `()`      | 撞击监测<br/>TODO:         |
| `_on_BulletTimer_timeout` | `()`      | 发射子弹, 同时建立声音连接 |

### HeroBullet

```tree
HeroBullet
├── AnimatedSprite
├── CollisionShape2D
└── VisibleNotifier2D
```

#### Attributes

| attribute | init      | max | desc         |
| :-------- | :-------- | :-- | :----------- |
| velocity  | (0, -300) | \\  | 二维移动速度 |
| power     | \\        | \\  | 子弹威力     |

#### Methods

| method                                   | args            | desc                           |
| :--------------------------------------- | :-------------- | :----------------------------- |
| `start`                                  | `(pos, ipower)` | 初始化子弹, 设置子弹威力和位置 |
| `_ready`                                 | `()`            | 预处理, nothing                |
| `_process`                               | `(delta)`       | 每帧处理, 前进                 |
| `_on_HeroBullet_body_entered`            | `(body)`        | 撞击监测                       |
| `_on_VisibilityNotifier2D_screen_exited` | `()`            | 超出屏幕后销毁                 |

### Mob

```tree
Hero
├── AnimatedSprite
├── CollisionShape2D
├── BulletTimer
├── EnemyBullet (通过 Timer 创建)
└── VisibleNotifier2D
```

#### Attributes

| attribute | init      | desc                             |
| :-------- | :-------- | :------------------------------- |
| hp        | 30        | 血量<br/>is_dead=true if hp <= 0 |
| power     | 30        | 子弹威力                         |
| velocity  | (0, -300) | 二维移动速度                     |
| is_dead   | false     | 是否死亡                         |

#### Methods

| method                                   | args      | desc                         |
| :--------------------------------------- | :-------- | :--------------------------- |
| `start`                                  | `(pos)`   | 初始化普通敌机, 设置子弹位置 |
| `end`                                    | `()`      | 普通敌机死亡处理             |
| `_ready`                                 | `()`      | 预处理, nothing              |
| `_process`                               | `(delta)` | 每帧处理, 前进               |
| `_on_VisibilityNotifier2D_screen_exited` | `()`      | 超出屏幕后销毁               |
| `_on_BulletTimer_timeout`                | `()`      | 发射子弹                     |

### EnemyBullet

```tree
EnemyBullet
├── AnimatedSprite
├── CollisionShape2D
└── VisibleNotifier2D
```

#### Attributes

| attribute | init      | max | desc         |
| :-------- | :-------- | :-- | :----------- |
| velocity  | (0, 300) | \\  | 二维移动速度 |
| power     | \\        | \\  | 子弹威力     |

#### Methods

| method                                   | args            | desc                           |
| :--------------------------------------- | :-------------- | :----------------------------- |
| `start`                                  | `(pos, ipower)` | 初始化子弹, 设置子弹威力和位置 |
| `_ready`                                 | `()`            | 预处理, nothing                |
| `_process`                               | `(delta)`       | 每帧处理, 前进                 |
| `_on_HeroBullet_body_entered`            | `(body)`        | 撞击监测                       |
| `_on_VisibilityNotifier2D_screen_exited` | `()`            | 超出屏幕后销毁                 |
