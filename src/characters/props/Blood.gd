class_name Blood extends FlyingObject

# Blood: Attributes
const increase_hp = 100
var is_dead = false

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
	if GameManager.is_sound_on and not is_dead:
		$GetSupply.play()
	is_dead = true
	hide()

# get hp
func get_increase():
	return -increase_hp
