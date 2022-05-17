extends Node

func _on_MessageHUD_start_game():
	$Game.new_game()


func _on_MessageHUD_music_changed():
	if not GameManager.is_sound_on:
		$Game.stop_music()
