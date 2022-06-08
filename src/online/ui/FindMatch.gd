extends CanvasLayer

func _ready():
	end()
	OnlineMatch.connect("matchmaker_matched", self, "OnMatchFound")


func OnMatchFound(players):
	print("Players Found: ", players)
	end()

func _on_Button_button_down():
	$Button.hide()
	$Label.show()

	if not Online.is_nakama_socket_connected():
		Online.connect_nakama_socket()
		yield(Online, "socket_connected")

	print("Looking for a Match...")
	var data = {
		min_count = 2
	}
	OnlineMatch.start_matchmaking(Online.nakama_socket, data)

func start():
	$Panel.show()
	$Button.show()

func end():
	$Panel.hide()
	$Label.hide()
	$Button.hide()
