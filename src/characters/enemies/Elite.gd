extends Area2D

export(PackedScene) var enemy_bullet_scene

# Mob: Attributes
var hp = GameManager.ELITE_MAX_HP
var power = 30
var velocity = Vector2((1 if randi() % 2 == 1 else -1) * randi() % 100, 150)
var score_value = 20

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
		end()

# shoot bullets
func _on_BulletTimer_timeout():
	var bullet = enemy_bullet_scene.instance()
	var pos = Vector2(position.x, position.y + 100)
	bullet.start(pos, power)
	get_parent().add_child(bullet)

# crash detection
func _on_Elite_area_entered(area:Area2D):
	if "HeroBullet" in area.name:
		hp -= area.power
		decreases_hp(area.call("get_power"))
		area.call("end")
	if area.name == "Hero":
		end()

# out of the boundary
func _on_VisibilityNotifier2D_screen_exited():
	end()

# init
func start(pos):
	GameManager.enemy_num += 1
	position = pos

# death
func end():
	hp = 0
	$BulletTimer.stop()
	GameManager.enemy_num -= 1
	queue_free()
	hide()

# decrease hp
func decreases_hp(damage):
	hp -= damage

# dead with score
func dead_score():
	decreases_hp(GameManager.ELITE_MAX_HP)
