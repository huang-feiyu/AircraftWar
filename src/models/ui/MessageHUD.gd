extends CanvasLayer


signal start_game

func _ready():
	$StartMessage.show()
	$EasyButton.show()
	$NormalButton.show()
	$HardButton.show()
	$MusicCheck.show()
	$EndMessage.hide()

func _on_EasyButton_pressed():
	GameManager.difficulty = 0
	GameManager.is_sound_on = $MusicCheck.toggle_mode
	emit_signal("start_game")
	$StartTimer.start()


func _on_NormalButton_pressed():
	GameManager.difficulty = 1
	GameManager.is_sound_on = $MusicCheck.toggle_mode
	emit_signal("start_game")
	$StartTimer.start()


func _on_HardButton_pressed():
	GameManager.difficulty = 2
	GameManager.is_sound_on = $MusicCheck.toggle_mode
	emit_signal("start_game")
	$StartTimer.start()

func _on_StartTimer_timeout():
	$StartMessage.hide()
	$EasyButton.hide()
	$NormalButton.hide()
	$HardButton.hide()
	$MusicCheck.hide()

func show_end_message():
	$EndMessage.show()
