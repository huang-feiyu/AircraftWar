extends Area2D

# HeroBullet: Attributes
var power = 0
var velocity = Vector2(0, -300)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
# aka. move_forward
func _process(delta):
	position.y += velocity.y * delta
	position.x += velocity.x * delta

# if crash something, remove the bullet
func _on_HeroBullet_body_entered(body):
	if body.name == "Elite" || body.name == "Mob" || body.name == "Boss":
		print("HeroBullet: hit " + body.name)
		queue_free()

# out of the boundary
func _on_VisibilityNotifier2D_screen_exited():
	# print("HeroBullet: out of the boundary")
	queue_free()

# init
func start(pos, ipower):
	self.position = pos
	self.position.y -= 100
	self.power = ipower
