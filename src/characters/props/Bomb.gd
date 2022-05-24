class_name Bomb extends BaseProp

func _ready():
	is_dead = false
	velocity = Vector2((1 if randi() % 2 == 1 else -1) * randi() % 100, 150)
	set_process(true)

func _process(delta):
	move(delta)

func _on_BombSound_finished():
	queue_free()

# end
func end():
	if GameManager.is_sound_on and not is_dead:
		$GetSupply.play()
		$BombSound.play()
	is_dead = true
	hide()
