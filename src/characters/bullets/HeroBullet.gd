class_name HeroBullet extends BaseBullet

# HeroBullet: Attributes
var power = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(0, -300)
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
# aka. move_forward
func _process(delta):
	move(delta)

# out of the boundary
func _on_VisibilityNotifier2D_screen_exited():
	# print("HeroBullet: out of the boundary")
	queue_free()

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

# get power
func get_power():
	return power
