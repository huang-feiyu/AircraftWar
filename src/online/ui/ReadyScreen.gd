extends CanvasLayer

export(PackedScene) var player_ready_scene

signal player_ready_signal()

func _ready():
	OnlineMatch.connect("player_joined", self, "PlayerJoined")
	OnlineMatch.connect("player_left", self, "PlayerLeft")
	OnlineMatch.connect("player_status_changed", self, "PlayerStatusChanged")
	OnlineMatch.connect("match_ready", self, "MatchReady")
	OnlineMatch.connect("match_not_ready", self, "MatchNotReady")
	OnlineMatch.connect("matchmaker_matched",self, "AddPlayers")
	end()

func AddPlayers(players):
	for id in players:
		var user_ready = player_ready_scene.instance()
		$VBoxContainer.add_child(user_ready)
		user_ready.set_username(players[id]["username"])
		user_ready.name = id

func PlayerJoined(player):
	pass

func PlayerLeft(player):
	pass

func PlayerStatusChanged(player, status):
	pass

func MatchReady(players):
	pass

func MatchNotReady():
	pass

func set_ready_status(id, status):
	var status_object = $VBoxContainer.get_node_or_null(id)
	if status_object:
		status_object.set_ready_status(status)

func _on_Button_button_down():
	emit_signal("player_ready_signal")

func end():
	$Panel.hide()
	$Button.hide()
	for id in $VBoxContainer.get_children():
		$VBoxContainer.remove_child(id)
	$VBoxContainer.hide()

func start():
	$Panel.show()
	$Button.show()
	$VBoxContainer.show()
