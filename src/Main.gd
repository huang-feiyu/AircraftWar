extends Node

func _on_MessageHUD_start_game():
	print("Difficulty: ", GameManager.difficulty)
	print("Music: ", GameManager.is_sound_on)
	$Game.new_game()


func _on_MessageHUD_music_changed():
	if not GameManager.is_sound_on:
		$Game.stop_music()


func _on_Game_game_over():
	$GameOverTimer.start()
	$MessageHUD.show_end_message()

func _on_GameOverTimer_timeout():
	$MessageHUD.hide_end_message()
	$GameOverTimer.stop()
	$RankList.start()

func _on_RankList_restart():
	print("Difficulty: ", GameManager.difficulty)
	print("Music: ", GameManager.is_sound_on)
	$MessageHUD.show_start_message()
