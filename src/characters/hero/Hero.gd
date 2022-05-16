extends Area2D

export(PackedScene) var hero_bullet_scene

# internal member
var dragging = false
var is_playing_bullet_sound = false

# Hero: Attributes
const MAX_HP = 1000
const MAX_SHOOT_NUM = 7
const MAX_POWER = 50
var hp = MAX_HP
var power = 30
var shoot_num = 1

signal is_dead

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	hide()

# death detection
func _process(delta):
	if hp <= 0:
		end()

# move_forward: dragging
func _input(event):
	# Code from: https://docs.godotengine.org/zh_CN/stable/tutorials/inputs/input_examples.html
	if event is InputEventScreenTouch:
		print("Hero: touch screen")
		# Start dragging if the click is on the sprite.
		if event.is_pressed():
			print("Hero: dragging now")
			dragging = true
		# Stop dragging if the button is released.
		else:
			dragging = false
	if event is InputEventScreenDrag and dragging:
		position = event.position

# shoot
func _on_BulletTimer_timeout():
	# print("Hero: shoot")
	var bullet = hero_bullet_scene.instance()
	bullet.start(position, power)
	get_parent().add_child(bullet)
	if !is_playing_bullet_sound:
		# play sound
		$BulletSound.play()
		is_playing_bullet_sound = true

# shoot bullet sound on after the previous one ends
func _on_BulletSound_finished():
	is_playing_bullet_sound = false

# crash detection
func _on_Hero_area_entered(area:Area2D):
	if "EnemyBullet" in area.name:
		decreases_hp(area.call("get_power"))
		# print("EnemyBullet hit; Hero hp:", hp)
		area.call("end")
	# if "Mob" in area.name:
	# 	self.end()

# init
func start(pos):
	position = pos
	$BulletTimer.start()
	show()

# death
func end():
	$BulletTimer.stop()
	queue_free()
	hide()

# decrease hp
func decreases_hp(damage):
	if hp - damage >= MAX_HP:
		hp = MAX_HP
	else:
		hp -= damage

