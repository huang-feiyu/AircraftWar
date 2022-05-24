class_name HeroBullet extends BaseBullet

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(0, -300)
	set_process(true)

# move_forward
func _process(delta):
	move(delta)

func _on_BulletHit_finished():
	queue_free()

# init
func start(pos, ipower):
	position = pos
	power = ipower

# end
func end():
	if GameManager.is_sound_on:
		$BulletHit.play()
	else:
		queue_free()
	hide()
