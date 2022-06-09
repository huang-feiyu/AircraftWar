extends Node

func _on_LoginHUD_login_done():
	$MessageHUD.show_start_message()

func _on_MessageHUD_start_game():
	print("Difficulty: ", GameManager.difficulty)
	print("Music: ", GameManager.is_sound_on)
	$Game.new_game()

func _on_Game_game_over():
	if GameManager.single:
		$GameOverTimer.start()
		$MessageHUD.show_end_message()

func _on_GameOverTimer_timeout():
	if GameManager.single:
		$GameOverTimer.stop()
		$RankList.start()

func _on_MessageHUD_music_changed():
	if not GameManager.is_sound_on:
		$Game.stop_music()

func _on_MessageHUD_restart_game():
	if GameManager.single:
		$MessageHUD.show_start_message()
		$RankList.end()

func _on_ChooseModeHUD_double():
	GameManager.single = false
	$WebMain.start()

func _on_ChooseModeHUD_single():
	GameManager.single = true
	$LoginHUD.start()
