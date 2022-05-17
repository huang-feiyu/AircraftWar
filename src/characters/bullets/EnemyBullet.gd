extends Area2D

# EnemyBullet: Attributes
var power = 0
var velocity = Vector2(0, 300)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += velocity.y * delta
	position.x += velocity.x * delta

# out of the boundary
func _on_VisibilityNotifier2D_screen_exited():
	# print("EnemyBullet: out of the boundary")
	queue_free()

# init
func start(pos, ipower):
	position = pos
	power = ipower

# end
func end():
	queue_free()
	hide()

# get power
func get_power():
	return power