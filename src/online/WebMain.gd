extends Node2D

signal login_done()

var ready_players = []

func _get_custom_rpc_methods():
	return [
		"player_is_ready"
	]

func _on_ReadyScreen_player_ready_signal():
	OnlineMatch.custom_rpc_sync(self, "player_is_ready", [OnlineMatch.get_my_session_id()])

func player_is_ready(id):
	$ReadyScreen.set_ready_status(id, "Ready")

	if OnlineMatch.is_network_server():
		ready_players.append(id)
		if ready_players.size() == OnlineMatch.players.size():
			OnlineMatch.start_playing()
			emit_signal("login_done")
			print("All Players are ready, lets start the game")
			end()

func start():
	$WebLoginHUD.start()
	$ReadyScreen.start()
	$FindMatch.start()

func end():
	$WebLoginHUD.end()
	$ReadyScreen.end()
	$FindMatch.end()
