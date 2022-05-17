extends Node

export(PackedScene) var mob_scene
export(PackedScene) var elite_scene
export(PackedScene) var boss_scene

var screen_size

signal boss_generate()
signal bgm_stop()
signal boss_bgm_stop()

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

	# boss
	if GameManager.score > GameManager.BOSS_GENERATE_SCORE * (GameManager.boss_count ) and !GameManager.is_boss_alive:
		emit_signal("boss_generate")
	if !GameManager.is_boss_alive and GameManager.is_sound_on:
		emit_signal("boss_bgm_stop")

	# bomb
	if GameManager.bomb_supply:
		GameManager.bomb_supply = false
		print("bomb supply")
		get_tree().call_group("mobs", "end")
		get_tree().call_group("elites", "end")

# boss generate
func _on_Game_boss_generate():
	GameManager.boss_count += 1
	GameManager.is_boss_alive = true
	var boss = boss_scene.instance()
	var pos = Vector2(rand_range(0.1, 0.9) * screen_size.x, rand_range(0.1, 0.2) * screen_size.y)
	boss.start(pos)
	add_child(boss)
	if GameManager.is_sound_on:
		emit_signal("bgm_stop")

func _on_Game_bgm_stop():
	if $BgmSound.is_playing():
		print("bgm playing, turn off")
		$BgmSound.stop()
	if not $BossBgmSound.is_playing():
		$BossBgmSound.play()

func _on_Game_boss_bgm_stop():
	if $BossBgmSound.is_playing():
		$BossBgmSound.stop()
	if not $BgmSound.is_playing():
		$BgmSound.play()

# replay bgm
func _on_BgmSound_finished():
	if not GameManager.is_boss_alive:
		$BgmSound.play()

# replay boss bgm
func _on_BossBgmSound_finished():
	if GameManager.is_boss_alive:
		$BossBgmSound.play()

# start a game
func new_game():
	$Hero.start($StartPosition.position)
	$StartTimer.start()
	if GameManager.is_sound_on:
		$BgmSound.play()

# end the game
func game_over():
	$StartTimer.stop()
	$EnemyTimer.stop()
	$BgmSound.stop()
	$BossBgmSound.stop()

# wait 1 seconds for the game to start
func _on_StartTimer_timeout():
	$EnemyTimer.start()

# new an enemy every 1 second
func _on_EnemyTimer_timeout():
	print("Enemy generate")
	if GameManager.enemy_num > GameManager.MAX_ENEMY_NUM:
		return
	var enemy = elite_scene.instance() if rand_range(0, 1) > GameManager.ELITE_POSSIBILITY else\
				mob_scene.instance()
	print("Enemy generate: ", enemy.name)
	var pos = Vector2(rand_range(0.1, 0.9) * screen_size.x, rand_range(0.1, 0.2) * screen_size.y)
	enemy.start(pos)
	add_child(enemy)

