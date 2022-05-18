class_name BaseBullet extends FlyingObject

# move
func move(delta):
	position.y += velocity.y * delta
	position.x += velocity.x * delta
