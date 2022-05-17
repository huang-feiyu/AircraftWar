class_name Elite extends Enemy

# Elite: Attributes
var score_value = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	hp = GameManager.ELITE_MAX_HP
	power = GameManager.ELITE_INIT_POWER
	velocity = Vector2((1 if randi() % 2 == 1 else -1) * randi() % 100, 150)
	$BulletTimer.start()

# move every frame
func _process(delta):
	move(delta)
	# death detection
	if hp <= 0:
		GameManager.score += score_value
		if rand_range(0, 1) < GameManager.ELITE_PROP_POSSIBILITY:
			prop_generate()
		end()

# shoot bullets
func _on_BulletTimer_timeout():
	var pos = Vector2(position.x, position.y + 100)
	shoot(pos)

# crash detection
func _on_Elite_area_entered(area:Area2D):
	bullet_detection(area)
	if area.name == "Hero":
		end()

# out of the boundary
func _on_VisibilityNotifier2D_screen_exited():
	end()

# init
func start(pos):
	base_start(pos)
	GameManager.enemy_num += 1

# death
func end():
	base_end()
	GameManager.enemy_num -= 1
