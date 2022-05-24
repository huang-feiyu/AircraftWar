class_name BaseBullet extends FlyingObject

# EnemyBullet: Attributes
var power = 0

# move
func move(delta):
	position.y += velocity.y * delta
	position.x += velocity.x * delta

func get_power():
	return power
