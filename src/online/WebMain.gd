extends Node2D

signal login_done()

var ready_players = {}

func _ready():
	login_end()

func _get_custom_rpc_methods():
	return [
		"player_is_ready"
	]

func _on_ReadyScreen_player_ready_signal():
	OnlineMatch.custom_rpc_sync(self, "player_is_ready", [OnlineMatch.get_my_session_id()])

func player_is_ready(id):
	$ReadyScreen.set_ready_status(id, "Ready")

	# if OnlineMatch.is_network_server():
	ready_players[id] = true
	if ready_players.size() == OnlineMatch.players.size():
		OnlineMatch.start_playing()
		emit_signal("login_done")
		start_game()

func _on_WebLoginHUD_weblogin_done():
	print("weblogin_done recevie")
	$MessageHUD.show_start_message()

func _on_MessageHUD_start_game():
	if not GameManager.single:
		$FindMatch.start()
		$ReadyScreen.start()

func _on_Game_game_over():
	if not GameManager.single:
		$MessageHUD.show_end_message()

func _on_MessageHUD_restart_game():
	if not GameManager.single:
		$MessageHUD.show_start_message()

func start():
	$WebLoginHUD.start()

func start_game():
	print("All Players are ready, lets start the game")
	$Game.new_game()
	login_end()

func login_end():
	$WebLoginHUD.end()
	$FindMatch.end()
	$ReadyScreen.end()
