class_name BaseProp extends FlyingObject

var is_dead # avoid multiple calls to end()

# init
func start(pos):
	position = pos

# out of boundary
func _on_VisibilityNotifier2D_screen_exited():
    # donot use end() here, it will cause a sound
	queue_free()