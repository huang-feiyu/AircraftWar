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
var is_dead = false

# Hero: Signals
signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	$BulletTimer.start()
	# hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
# aka. move_foward
func _process(delta):
	pass

# dragging
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
		self.position = event.position


# hit
func _on_Hero_hit():
	pass # Replace with function body.

# shoot
func _on_BulletTimer_timeout():
	# print("Hero: shoot")
	var bullet = hero_bullet_scene.instance()
	bullet.position = self.position
	bullet.position.y -= 100
	get_parent().add_child(bullet)
	if !is_playing_bullet_sound:
		# play sound
		$BulletSound.play()
		is_playing_bullet_sound = true

func _on_BulletSound_finished():
	is_playing_bullet_sound = false

# init
func start(pos):
	self.position = pos
	# show()
	# $CollisionShape2D.disabled = false

# death
func end():
	$BulletTime.stop()
	is_dead = true


