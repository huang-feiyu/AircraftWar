class_name FlyingObject extends Area2D

var velocity

# move
func move(delta):
	position.y += velocity.y * delta
	position.x += velocity.x * delta
	if position.x >= get_viewport().size.x * 0.9 or position.x <= get_viewport().size.x * 0.1:
		velocity.x = -velocity.x
