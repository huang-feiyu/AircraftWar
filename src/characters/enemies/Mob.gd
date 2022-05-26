class_name Mob extends Enemy

# Mob: Attributes
const score_value = 10

# init for every mob
func _ready():
	hp = GameManager.MOB_MAX_HP
	power = GameManager.MOB_INIT_POWER
	velocity = GameManager.mob_init_velocity
	$BulletTimer.set_wait_time(GameManager.GAME_ENEMY_SHOOT_TIME)
	$BulletTimer.start()

# move every frame
func _process(delta):
	move(delta)
	if hp <= 0:
		GameManager.score += score_value
		end()

# shoot bullets
func _on_BulletTimer_timeout():
	var pos = Vector2(position.x, position.y + 100)
	shoot(pos)

# crash detection
func _on_Mob_area_entered(area:Area2D):
	bullet_detection(area)
	if area.name == "Hero":
		end()

# init
func start(pos):
	base_start(pos)
	GameManager.enemy_num += 1

# death
func end():
	base_end()
	GameManager.enemy_num -= 1
