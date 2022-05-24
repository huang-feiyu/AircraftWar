class_name Bullet extends BaseProp

# Bullet: Attributes
const increase_bullet = 2

func _ready():
	is_dead = false
	velocity = Vector2((1 if randi() % 2 == 1 else -1) * randi() % 100, 150)
	set_process(true)

func _process(delta):
	move(delta)

func _on_GetSupply_finished():
	queue_free()

# end
func end():
	if GameManager.is_sound_on and not is_dead:
		$GetSupply.play()
	is_dead = true
	hide()

# get bullet
func get_increase():
	return increase_bullet
