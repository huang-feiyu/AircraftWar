extends Area2D

export(PackedScene) var enemy_bullet_scene

# Mob: Attributes
var hp = 30
var power = 30
var is_dead = false
var velocity = Vector2(0, 150)


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	$BulletTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += velocity.y * delta
	position.x += velocity.x * delta
	if hp <= 0:
		end()

# shoot bullets
func _on_BulletTimer_timeout():
	# print("Hero: shoot")
	var bullet = enemy_bullet_scene.instance()
	bullet.start(position, power)
	get_parent().add_child(bullet)

# crash detection
func _on_Mob_area_entered(area:Area2D):
	if "HeroBullet" in area.name:
		hp -= area.power
		decreases_hp(area.call("get_power"))
		print("HeroBullet hit")
		area.call("end")
	if area.name == "Hero":
		end()

# out of the boundary
func _on_VisibilityNotifier2D_screen_exited():
	end()

# init
func start(pos):
	position = pos

# death
func end():
	$BulletTimer.stop()
	is_dead = true
	queue_free()
	hide()

# decrease hp
func decreases_hp(damage):
	hp -= damage
