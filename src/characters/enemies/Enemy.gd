class_name Enemy extends FlyingObject

export(PackedScene) var enemy_bullet_scene
export(PackedScene) var blood_prop_scene
export(PackedScene) var bullet_prop_scene
export(PackedScene) var bomb_prop_scene

var power
var hp

# init
func base_start(pos):
	position = pos

# death
func base_end():
	hp = 0
	$BulletTimer.stop()
	queue_free()
	hide()

# shoot
func shoot(pos):
	var bullet = enemy_bullet_scene.instance()
	bullet.start(pos, power)
	get_parent().add_child(bullet)

# bullet detection
func bullet_detection(area:Area2D):
	if "HeroBullet" in area.name:
		hp -= area.power
		decreases_hp(area.call("get_power"))
		area.call("end")

# decrease hp
func decreases_hp(damage):
	hp -= damage

# generate props
func prop_generate():
	var switch = randi() % 3
	var prop = blood_prop_scene.instance() if switch == 0 \
				else bullet_prop_scene.instance() if switch == 1 \
				else bomb_prop_scene.instance()
	prop.start(position)
	get_parent().add_child(prop)

