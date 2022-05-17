extends Node

var difficulty = 0 # 0 => easy; 1 => medium; 2 => hard

var score = 0
var is_sound_on = true
var bomb_supply = false

# Hero
var hero_hp = HERO_MAX_HP
var hero_bullet_num = HERO_INIT_BULLET_NUM

# Enemies
var enemy_num = 0
var boss_count = 0
var boss_alive = 0

const HERO_MAX_HP = 1000
const HERO_MAX_POWER = 50
const HERO_INIT_POWER = 30
const HERO_INIT_BULLET_NUM = 3

const MOB_MAX_HP = 30
const ELITE_MAX_HP = 1000
const BOSS_MAX_HP = 10000

const MOB_INIT_BULLET_NUM = 1
const ELITE_INIT_BULLET_NUM = 1
const BOSS_INIT_BULLET_NUM = 3

const MOB_INIT_POWER = 10
const ELITE_INIT_POWER = 15
const BOSS_INIT_POWER = 10

const MAX_ENEMY_NUM = 20

const ELITE_POSSIBILITY = 0.5
const ELITE_PROP_POSSIBILITY = 0.3

const BOSS_GENERATE_SCORE = 1000

