extends Area2D

export(PackedScene) var enemy_bullet_scene
export(PackedScene) var blood_prop_scene
export(PackedScene) var bullet_prop_scene
export(PackedScene) var bomb_prop_scene

# Boss: Attributes
var hp = GameManager.BOSS_MAX_HP
var power = 10
var velocity = Vector2(50, 0)
var score_value = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	$BulletTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += velocity.y * delta
	position.x += velocity.x * delta
	if position.x >= get_viewport().size.x * 0.9 || position.x <= get_viewport().size.x * 0.1:
		velocity.x = -velocity.x
	if hp <= 0:
		GameManager.score += score_value
		print("Score:", GameManager.score)
		prop_generate()
		end()

# shoot bullets
func _on_BulletTimer_timeout():
	for i in range(GameManager.boss_bullet_num):
		var bullet = enemy_bullet_scene.instance()
		var pos = Vector2(position.x + (i - GameManager.boss_bullet_num / 2) * 40, position.y + 200)
		bullet.start(pos, power)
		get_parent().add_child(bullet)

# crash detection
func _on_Boss_area_entered(area:Area2D):
	if "HeroBullet" in area.name:
		hp -= area.power
		decreases_hp(area.call("get_power"))
		area.call("end")
	if area.name == "Hero":
		end()

# init
func start(pos):
	position = pos

# death
func end():
	hp = 0
	$BulletTimer.stop()
	queue_free()
	hide()
	GameManager.is_boss_alive = false

# decrease hp
func decreases_hp(damage):
	hp -= damage

# dead with score
func dead_score():
	decreases_hp(GameManager.BOSS_MAX_HP)

# generate props
func prop_generate():
	var switch = randi() % 3
	var prop = blood_prop_scene.instance() if switch == 0 \
				else bullet_prop_scene.instance() if switch == 1 \
				else bomb_prop_scene.instance()
	prop.start(position)
	get_parent().add_child(prop)
