class_name Bullet extends FlyingObject

# Bullet: Attributes
const increase_bullet = 2

func _ready():
	velocity = Vector2((1 if randi() % 2 == 1 else -1) * randi() % 100, 150)
	set_process(true)

func _process(delta):
	move(delta)

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
	if GameManager.is_sound_on:
		$GetSupply.play()
	hide()

# get bullet
func get_increase():
	return increase_bullet
