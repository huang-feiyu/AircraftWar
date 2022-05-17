extends Node

var score = 0
var is_sound_on = true

# Hero
var hero_hp = HERO_MAX_HP
var hero_bullet_num = 3

# Enemies
var enemy_num = 0
var boss_count = 0
var boss_bullet_num = 6
var is_boss_alive = false


const HERO_MAX_HP = 100000
const HERO_MAX_SHOOT_NUM = 7
const HERO_MAX_POWER = 50

const MOB_MAX_HP = 30
const ELITE_MAX_HP = 50
const BOSS_MAX_HP = 5000

const MAX_ENEMY_NUM = 20

const ELITE_POSSIBILITY = 0.5

const BOSS_GENERATE_SCORE = 1000

