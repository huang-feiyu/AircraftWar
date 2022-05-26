class_name EnemyBullet extends BaseBullet

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)

# move forward
func _process(delta):
	move(delta)

# init
func start(pos, ipower):
	position = pos
	power = ipower
	velocity = GameManager.bullet_init_velocity

# end
func end():
	queue_free()
	hide()
