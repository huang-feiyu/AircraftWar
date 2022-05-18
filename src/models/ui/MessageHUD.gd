extends CanvasLayer

const bg_dir = "res://assets/img/bg/"

signal start_game
signal music_changed

func _ready():
	show_start_message()

func _on_EasyButton_pressed():
	GameManager.difficulty = 0
	change_bg_img()
	emit_signal("start_game")
	$StartTimer.start()


func _on_NormalButton_pressed():
	GameManager.difficulty = 1
	change_bg_img()
	emit_signal("start_game")
	$StartTimer.start()


func _on_HardButton_pressed():
	GameManager.difficulty = 2
	change_bg_img()
	emit_signal("start_game")
	$StartTimer.start()

func _on_StartTimer_timeout():
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

func show_end_message():
	$EndMessage.show()

func change_bg_img():
	if GameManager.difficulty == 0:
		GameManager.bg_img = bg_dir + "bg.jpg"
	elif GameManager.difficulty == 1:
		GameManager.bg_img = bg_dir + "bg2.jpg" if randi() % 2 == 0 else bg_dir + "bg3.jpg"
	else:
		GameManager.bg_img = bg_dir + "bg4.jpg" if randi() % 2 == 0 else bg_dir + "bg5.jpg"
