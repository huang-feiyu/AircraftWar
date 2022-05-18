extends Node

# nothing done here
func straight(bullets):
	bullets = bullets

# nothing done here
func scattering(bullets):
	var size = bullets.size()
	for i in range(size):
		bullets[i].velocity.x = (i - size / 2) * 20
