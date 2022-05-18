extends Area2D

export(PackedScene) var hero_bullet_scene

# internal member
var dragging = false
var is_playing_bullet_sound = false
var is_bullet_prop = false
var increase_bullet = 0

# Hero: Attributes
var hp = GameManager.HERO_MAX_HP
var power = GameManager.HERO_INIT_POWER
var is_hero_dead = false

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
	for i in range(GameManager.hero_bullet_num):
		var bullet = hero_bullet_scene.instance()
		bullets.append(bullet)
		var pos = Vector2(position.x + (i - GameManager.hero_bullet_num / 2) * 40, position.y - 80)
		bullet.start(pos, power)
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

	# props
	elif "Blood" in area.name:
		decreases_hp(area.call("get_increase"))
		area.call("end")
	elif "Bullet" in area.name and not "Hero" in area.name:
		increase_bullet = area.call("get_increase")
		GameManager.hero_bullet_num += 0 if is_bullet_prop else increase_bullet
		is_bullet_prop = true
		area.call("end")
		$BulletPropTimer.start()
	elif "Bomb" in area.name:
		GameManager.bomb_supply = true
		area.call("end")

# 5 seconds
func _on_BulletPropTimer_timeout():
	GameManager.hero_bullet_num = GameManager.HERO_INIT_BULLET_NUM
	is_bullet_prop = false
	$BulletPropTimer.stop()

# init
func start(pos):
	is_hero_dead = false
	print("init hero")
	hp = GameManager.HERO_MAX_HP
	GameManager.hero_hp = hp
	position = pos
	$BulletTimer.start()
	show()

# death
func end():
	hp = 0
	emit_signal("hero_dead")
	print("hero emit hero_dead")
	GameManager.hero_hp = hp
	$BulletTimer.stop()
	hide()
	is_hero_dead = true

# decrease hp
func decreases_hp(damage):
	if hp - damage >= GameManager.HERO_MAX_HP:
		hp = GameManager.HERO_MAX_HP
	else:
		hp -= damage
	GameManager.hero_hp = hp
