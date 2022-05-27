extends Node

export(PackedScene) var mob_scene
export(PackedScene) var elite_scene
export(PackedScene) var boss_scene

var screen_size
var is_game_over = false

signal boss_generate()
signal bgm_stop()
signal boss_bgm_stop()

signal game_over # to Main

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().size
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# death dectection
	$PlayHUD.call("update_hp")
	$PlayHUD.call("update_score")

	# boss
	if GameManager.score > GameManager.BOSS_GENERATE_SCORE * (GameManager.boss_count + 1):
		emit_signal("boss_generate")
	if !GameManager.boss_alive >= 1 and GameManager.is_sound_on:
		emit_signal("boss_bgm_stop")

	# bomb
	if GameManager.bomb_supply:
		GameManager.bomb_supply = false
		print("bomb supply")
		get_tree().call_group("enemy", "end")

# boss generate
func _on_Game_boss_generate():
	GameManager.boss_count += 1
	var boss = boss_scene.instance()
	boss.start(Vector2(rand_range(0.1, 0.9) * screen_size.x, rand_range(0.1, 0.2) * screen_size.y))
	add_child(boss)
	if GameManager.is_sound_on:
		emit_signal("bgm_stop")

# wait 1 seconds for the game to start
func _on_StartTimer_timeout():
	$StartTimer.stop()
	$PlayHUD.start_game()
	$EnemyTimer.start()
	$Hero.start($StartPosition.position)

# new an enemy every 1 second
func _on_EnemyTimer_timeout():
	if GameManager.enemy_num > GameManager.MAX_ENEMY_NUM:
		return
	var enemy = elite_scene.instance() if rand_range(0, 1) > GameManager.ELITE_POSSIBILITY else\
				mob_scene.instance()
	var pos = Vector2(rand_range(0.1, 0.9) * screen_size.x, rand_range(0.1, 0.2) * screen_size.y)
	enemy.start(pos)
	add_child(enemy)

# update
func _on_DifficultyTimer_timeout():
	if not is_game_over:
		GameManager.update()

# game over
func _on_Hero_hero_dead():
	game_over()

# start a game
func new_game():
	is_game_over = false
	print("Game: game start")
	$StartTimer.start()
	$DifficultyTimer.start()

	GameManager.init()
	if GameManager.is_sound_on:
		$BgmSound.play()
	else:
		$BgmSound.stop()
	$BgImg.texture = load(GameManager.bg_img)
	$BgImg.rect_scale = Vector2(screen_size.x / 512, screen_size.y / 768)
	$EnemyTimer.set_wait_time(GameManager.GAME_ENEMY_TIME)

# end the game
func game_over():
	is_game_over = true
	print("Game: game over")
	$StartTimer.stop()
	$DifficultyTimer.start()
	$EnemyTimer.stop()
	$PlayHUD.game_over()
	get_tree().call_group("all", "queue_free")
	stop_music()

	if GameManager.is_sound_on:
		$GameOverSound.play()
	emit_signal("game_over")

# music
func _on_Game_bgm_stop():
	if $BgmSound.is_playing():
		print("nomral bgm stop")
		$BgmSound.stop()
	if not $BossBgmSound.is_playing() and GameManager.is_sound_on:
		print("boss bgm start")
		$BossBgmSound.play()

func _on_Game_boss_bgm_stop():
	if $BossBgmSound.is_playing():
		print("boss bgm stop")
		$BossBgmSound.stop()
	if not $BgmSound.is_playing() and GameManager.is_sound_on and not is_game_over:
		print("normal bgm start")
		$BgmSound.play()

# replay bgm
func _on_BgmSound_finished():
	if GameManager.boss_alive < 1 and GameManager.is_sound_on and not is_game_over:
		$BgmSound.play()

# replay boss bgm
func _on_BossBgmSound_finished():
	if GameManager.boss_alive >= 1 and GameManager.is_sound_on and not is_game_over:
		$BossBgmSound.play()

# stop all music
func stop_music():
	$BgmSound.stop()
	$BossBgmSound.stop()
