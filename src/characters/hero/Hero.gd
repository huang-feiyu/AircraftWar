extends Area2D

var click_radius = 10000 # Size of the sprite
var dragging = false

# Hero: Attributes
const MAX_HP = 1000
const MAX_SHOOT_NUM = 7
const MAX_POWER = 50
var hp
var power
var shoot_num
var is_dead

# Hero: Signals
signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	hp = MAX_HP
	power = 30
	shoot_num = 1
	is_dead = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
# aka. move_foward
func _process(delta):
	if dragging:
		var mousepos = get_viewport().get_mouse_position()
		self.position = Vector2(mousepos.x, mousepos.y)

func _on_Hero_input_event(viewport, event, shape_idx):
	# Code from: https://docs.godotengine.org/zh_CN/stable/tutorials/inputs/input_examples.html
	if event is InputEventScreenTouch:
		print("Hero: touch screen")
		# Start dragging if the click is on the sprite.
		if event.is_pressed():
			print("Hero: dragging now")
			dragging = true
		# Stop dragging if the button is released.
		else:
			dragging = false
			self.position = event.position


# hit
func _on_Hero_hit():
	pass # Replace with function body.

