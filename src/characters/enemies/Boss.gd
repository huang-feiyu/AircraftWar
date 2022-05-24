class_name Boss extends Enemy

# Boss: Attributes
const score_value = 100
var bullet_num = GameManager.BOSS_INIT_BULLET_NUM

# Called when the node enters the scene tree for the first time.
func _ready():
	hp = GameManager.BOSS_MAX_HP
	power = GameManager.BOSS_INIT_POWER
	velocity = Vector2(50, 0)
	$BulletTimer.start()

# move every frame
func _process(delta):
	move(delta)
	if hp <= 0:
		GameManager.score += score_value
		prop_generate()
		end()

# shoot bullets
func _on_BulletTimer_timeout():
	var bullets = []
	for i in range(bullet_num):
		var bullet = enemy_bullet_scene.instance()
		bullet.start(Vector2(position.x + (i - bullet_num / 2) * 40, position.y + 200), power)
		bullets.append(bullet)
		get_parent().add_child(bullet)
	# strategy
	if randi() % 2 == 1:
		$BulletStrategy.scattering(bullets)
	else:
		$BulletStrategy.straight(bullets)

# crash detection
func _on_Boss_area_entered(area:Area2D):
	bullet_detection(area)
	if area.name == "Hero":
		end()

# init
func start(pos):
	base_start(pos)
	GameManager.boss_alive += 1

# death
func end():
	base_end()
	GameManager.boss_alive -= 1
