extends Area2D

# Bullet: Attributes
const increase_bullet = 2
var velocity = Vector2((1 if randi() % 2 == 1 else -1) * randi() % 100, 150)

func _ready():
	set_process(true)

func _process(delta):
	position.y += velocity.y * delta
	position.x += velocity.x * delta
	if position.x >= get_viewport().size.x * 0.9 || position.x <= get_viewport().size.x * 0.1:
		velocity.x = -velocity.x

func _on_GetSupply_finished():
	queue_free()

# out of boundary
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

# init
func start(pos):
	position = pos

# end
func end():
	$GetSupply.play()
	hide()

# get bullet
func get_increase():
	return increase_bullet
