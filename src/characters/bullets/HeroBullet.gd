extends Area2D

# HeroBullet: Attributes
var speed_x = 0
var speed_y = -300
var power

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
# aka. move_forward
func _process(delta):
	position.y += speed_y * delta
	position.x += speed_x * delta

# if crash something, remove the bullet
func _on_HeroBullet_body_entered(body):
	if body.name == "Elite" || body.name == "Mob" || body.name == "Boss":
		print("HeroBullet: hit " + body.name)
		queue_free()

# out of the boundary
func _on_VisibilityNotifier2D_screen_exited():
	# print("HeroBullet: out of the boundary")
	queue_free()
