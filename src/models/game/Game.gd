extends Node

export(PackedScene) var mob_scene

const MAX_ENEMY_NUM = 20

var screen_size
var score
var enemy_num = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().size
	randomize()
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# death dectection
	pass

# start a game
func new_game():
	score = 0
	$Hero.start($StartPosition.position)
	$StartTimer.start()
	# get_tree().call_group("mobs", "queue_free")

# end the game
func game_over():
	$StartTimer.stop()
	$EnemyTimer.stop()

# wait 2 seconds for the game to start
func _on_StartTimer_timeout():
	$EnemyTimer.start()

# new a mob every 1 second
func _on_EnemyTimer_timeout():
	var mob = mob_scene.instance()
	var pos = Vector2(rand_range(0, screen_size.x), rand_range(0, 0.2) * screen_size.y)
	mob.start(pos)
	add_child(mob)

