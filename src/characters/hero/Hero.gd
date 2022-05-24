extends Area2D

export(PackedScene) var hero_bullet_scene

# internal member
var dragging = false
var is_bullet_prop = false # only add bullet num once

# Hero: Attributes
var hp = GameManager.HERO_MAX_HP
var power = GameManager.HERO_INIT_POWER
var bullet_num = GameManager.HERO_INIT_BULLET_NUM
var is_hero_dead = false # for emit death signal

signal hero_dead

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	hide()

# death detection
func _process(delta):
	if hp <= 0 and not is_hero_dead:
		end()

# move_forward: dragging
func _input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			dragging = true
		else:
			dragging = false
	if event is InputEventScreenDrag and dragging:
		position = event.position

# shoot
func _on_BulletTimer_timeout():
	var bullets = []
	for i in range(bullet_num):
		var bullet = hero_bullet_scene.instance()
		bullet.start(Vector2(position.x + (i - bullet_num / 2) * 40, position.y - 80), power)
		bullets.append(bullet)
		get_parent().add_child(bullet)
	# bullet strategy
	if is_bullet_prop:
		$BulletStrategy.scattering(bullets)
	else:
		$BulletStrategy.straight(bullets)

# crash detection
func _on_Hero_area_entered(area:Area2D):
	if "EnemyBullet" in area.name:
		decreases_hp(area.call("get_power"))
		area.call("end")
	elif "Mob" in area.name or "Boss" in area.name or "Elite" in area.name:
		end()
	else:
		crash_prop(area)

# 5 seconds
func _on_BulletPropTimer_timeout():
	bullet_num = GameManager.HERO_INIT_BULLET_NUM
	is_bullet_prop = false
	$BulletPropTimer.stop()

# init
func start(pos):
	print("hero init")
	hp = GameManager.HERO_MAX_HP
	position = pos
	is_hero_dead = false
	$BulletTimer.start()
	show()

	bullet_num = GameManager.HERO_INIT_BULLET_NUM
	is_bullet_prop = false

# death
func end():
	print("hero dead")
	hp = 0
	GameManager.hero_hp = hp
	is_hero_dead = true
	$BulletTimer.stop()
	hide()

	emit_signal("hero_dead")

# decrease hp
func decreases_hp(damage):
	if hp - damage >= GameManager.HERO_MAX_HP:
		hp = GameManager.HERO_MAX_HP
	else:
		hp -= damage
	GameManager.hero_hp = hp

func crash_prop(prop):
	# props
	if "Blood" in prop.name:
		decreases_hp(prop.call("get_increase"))
		prop.call("end")
	elif "Bullet" in prop.name and not "Hero" in prop.name:
		bullet_num += 0 if is_bullet_prop else prop.call("get_increase")
		is_bullet_prop = true
		prop.call("end")
		$BulletPropTimer.start() # restart bullet prop timer
	elif "Bomb" in prop.name:
		GameManager.bomb_supply = true
		prop.call("end")
