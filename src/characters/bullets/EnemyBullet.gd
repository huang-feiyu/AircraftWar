class_name EnemyBullet extends BaseBullet

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(0, 300)
	set_process(true)

# move forward
func _process(delta):
	move(delta)

# init
func start(pos, ipower):
	position = pos
	power = ipower

# end
func end():
	queue_free()
	hide()
