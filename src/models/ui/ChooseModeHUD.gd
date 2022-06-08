extends CanvasLayer

signal single()
signal double()

# Called when the node enters the scene tree for the first time.
func _ready():
	end()
	start()

func start():
	$StartMessage.show()
	$SingleButton.show()
	$DoubleButton.show()

func end():
	$StartMessage.hide()
	$SingleButton.hide()
	$DoubleButton.hide()


func _on_SingleButton_button_down():
	emit_signal("single")
	end()

func _on_DoubleButton_button_down():
	emit_signal("double")
	end()
