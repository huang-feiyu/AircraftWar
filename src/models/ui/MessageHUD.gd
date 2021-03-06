extends CanvasLayer

const bg_dir = "res://assets/img/bg/"

signal start_game
signal restart_game()
signal music_changed

func _ready():
	$StartMessage.hide()
	$EasyButton.hide()
	$NormalButton.hide()
	$HardButton.hide()
	$MusicCheck.hide()
	$EndMessage.hide()
	$VSMessage.hide()
	$NextGameButton.hide()

func _on_EasyButton_pressed():
	GameManager.difficulty = 0
	start_game()

func _on_NormalButton_pressed():
	GameManager.difficulty = 1
	start_game()

func _on_HardButton_pressed():
	GameManager.difficulty = 2
	start_game()

func _on_StartTimer_timeout():
	$StartTimer.stop()
	$StartMessage.hide()
	$EasyButton.hide()
	$NormalButton.hide()
	$HardButton.hide()
	$MusicCheck.hide()

func _on_MusicCheck_toggled(button_pressed):
	GameManager.is_sound_on = not GameManager.is_sound_on
	emit_signal("music_changed")

func show_start_message():
	$StartMessage.show()
	$EasyButton.show()
	$NormalButton.show()
	$HardButton.show()
	$MusicCheck.show()
	$EndMessage.hide()
	$NextGameButton.hide()

func show_end_message():
	print("End Score: ", GameManager.score)
	if not GameManager.single:
		update_score()
	else:
		$EndTimer.start(1)
	$EndMessage.show()

func _on_EndTimer_timeout():
	$EndTimer.stop()
	$EndMessage.hide()
	$NextGameButton.show()
	$VSMessage.hide()

func _on_NextGameButton_button_down():
	print("\nRestart")
	$NextGameButton.hide()
	emit_signal("restart_game")

func start_game():
	if GameManager.difficulty == 0:
		GameManager.bg_img = bg_dir + "bg.jpg"
	elif GameManager.difficulty == 1:
		GameManager.bg_img = bg_dir + "bg2.jpg" if randi() % 2 == 0 else bg_dir + "bg3.jpg"
	else:
		GameManager.bg_img = bg_dir + "bg4.jpg" if randi() % 2 == 0 else bg_dir + "bg5.jpg"
	emit_signal("start_game")
	$StartTimer.start()

func update_score():
	$EndMessage.hide()
	if GameManager.score > GameManager.opponent_score:
		$EndMessage.text = "You win!"
	else:
		$EndMessage.text = "You lose!"
	$EndMessage.show()
	$VSMessage.hide()
	$VSMessage.text = str(GameManager.score) + " vs " + str(GameManager.opponent_score)
	$VSMessage.show()
