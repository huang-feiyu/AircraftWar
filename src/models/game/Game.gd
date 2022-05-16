extends Node

export(PackedScene) var mob_scene

const MAX_ENEMY_NUM = 20

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().size
	randomize()
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# death dectection
	$PlayHUD.call("update_hp")
	$PlayHUD.call("update_score")

# start a game
func new_game():
	$Hero.start($StartPosition.position)
	$StartTimer.start()

# end the game
func game_over():
	$StartTimer.stop()
	$EnemyTimer.stop()

# wait 1 seconds for the game to start
func _on_StartTimer_timeout():
	$EnemyTimer.start()

# new a mob every 1 second
func _on_EnemyTimer_timeout():
	if GameManager.enemy_num > MAX_ENEMY_NUM:
		return
	var mob = mob_scene.instance()
	var pos = Vector2(rand_range(0, screen_size.x), rand_range(0.1, 0.2) * screen_size.y)
	mob.start(pos)
	add_child(mob)

