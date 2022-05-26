extends Node

# init by users
var difficulty = 0 # 0 => easy; 1 => medium; 2 => hard
var is_sound_on = false
var bg_img = "res://assets/img/bg/bg.jpg"

# global variables
var score = 0
var bomb_supply = false

# Hero
var hero_hp = HERO_MAX_HP # for PlayHUD

# Enemies
var enemy_num = 0 # limit the number of enemies
var boss_count = 0 # for init boss, compare to generate threshold
var boss_alive = 0 # for boss BGM

# Game Attributes (for difficulty)
var GAME_ENEMY_TIME = 1
var GAME_ENEMY_SHOOT_TIME = 0.5
var GAME_HERO_SHOOT_TIME = 0.25
var BOSS_GENERATE_SCORE = 100
var BOSS_INIT_BULLET_NUM = 5
var mob_init_velocity = Vector2(0, 125)
var elite_init_velocity = Vector2(75, 150)
var boss_init_velocity = Vector2(50, 0)
var bullet_init_velocity = Vector2(0, 300)

const HERO_MAX_HP = 1000
const HERO_INIT_POWER = 30
const HERO_INIT_BULLET_NUM = 3

const MOB_MAX_HP = 100
const ELITE_MAX_HP = 500
const BOSS_MAX_HP = 10000

const MOB_INIT_BULLET_NUM = 1
const ELITE_INIT_BULLET_NUM = 1

const MOB_INIT_POWER = 10
const ELITE_INIT_POWER = 15
const BOSS_INIT_POWER = 10

const MAX_ENEMY_NUM = 20

const ELITE_POSSIBILITY = 0.5
const ELITE_PROP_POSSIBILITY = 0.3

func init():
	score = 0
	bomb_supply = false
	hero_hp = HERO_MAX_HP
	enemy_num = 0
	boss_count = 0
	boss_alive = 0
	start()

func start():
	if difficulty == 0:
		GAME_ENEMY_TIME = 1
		GAME_ENEMY_SHOOT_TIME = 0.8
		GAME_HERO_SHOOT_TIME = 0.25
		BOSS_GENERATE_SCORE = 1000
		BOSS_INIT_BULLET_NUM = 5
		mob_init_velocity = Vector2(0, 125)
		elite_init_velocity = Vector2(75, 150)
		boss_init_velocity = Vector2(50, 0)
		bullet_init_velocity = Vector2(0, 300)
	elif difficulty == 1:
		GAME_ENEMY_TIME = 0.75
		GAME_ENEMY_SHOOT_TIME = 0.4
		GAME_HERO_SHOOT_TIME = 0.23
		BOSS_GENERATE_SCORE = 750
		BOSS_INIT_BULLET_NUM = 7
		mob_init_velocity = Vector2(0, 200)
		elite_init_velocity = Vector2(100, 250)
		boss_init_velocity = Vector2(50, 0)
		bullet_init_velocity = Vector2(0, 400)
	elif difficulty == 2:
		GAME_ENEMY_TIME = 0.5
		GAME_ENEMY_SHOOT_TIME = 0.2
		GAME_HERO_SHOOT_TIME = 0.2
		BOSS_GENERATE_SCORE = 500
		BOSS_INIT_BULLET_NUM = 9
		mob_init_velocity = Vector2(0, 250)
		elite_init_velocity = Vector2(125, 300)
		boss_init_velocity = Vector2(50, 0)
		bullet_init_velocity = Vector2(0, 500)

func update():
	if difficulty == 1:
		mob_init_velocity = multiple(mob_init_velocity, 1.1)
		elite_init_velocity = multiple(elite_init_velocity, 1.1)
		boss_init_velocity = multiple(boss_init_velocity, 1.1)
		bullet_init_velocity = multiple(bullet_init_velocity, 1.1)
	elif difficulty == 2:
		mob_init_velocity = multiple(mob_init_velocity, 1.2)
		elite_init_velocity = multiple(elite_init_velocity, 1.2)
		boss_init_velocity = multiple(boss_init_velocity, 1.2)
		bullet_init_velocity = multiple(bullet_init_velocity, 1.2)
	print("Enemies speed up")

func multiple(vec, num):
	return Vector2(vec.x * num, vec.y * num)
