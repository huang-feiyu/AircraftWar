extends Node

func straight(bullets):
	var prev = bullets[bullets.size() / 2]
	for bullet in bullets:
		bullet.position = Vector2(prev.position.x, prev.position.y - 10)
		prev = bullet

# nothing done here
func scattering(bullets):
	var size = bullets.size()
	for i in range(size):
		bullets[i].velocity.x = (i - size / 2) * 20
