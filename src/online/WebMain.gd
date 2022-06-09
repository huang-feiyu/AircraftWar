extends Node2D

var ready_players = {}

var player_scene = preload("res://src/online/Player.tscn")
var opponent_score = 0

var all_players = {}
var alive_players = {}

signal web_game_over

func _ready():
	login_end()

func _get_custom_rpc_methods():
	return [
		"player_is_ready",
		"setup_game",
		"finish_setup"
	]

func _on_ReadyScreen_player_ready_signal():
	OnlineMatch.custom_rpc_sync(self, "player_is_ready", [OnlineMatch.get_my_session_id()])

func player_is_ready(id):
	$ReadyScreen.set_ready_status(id, "Ready")

	# if OnlineMatch.is_network_server():
	ready_players[id] = true
	if ready_players.size() == OnlineMatch.players.size():
		OnlineMatch.start_playing()
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
	login_end()
	OnlineMatch.custom_rpc_sync(self, "setup_game", [OnlineMatch.get_player_names_by_peer_id()])

func login_end():
	$WebLoginHUD.end()
	$FindMatch.end()
	$ReadyScreen.end()

func setup_game(players):
	all_players = players
	alive_players = players

	for id in players:
		var currentPlayer = player_scene.instance()
		currentPlayer.name = str(id)
		$Player.add_child(currentPlayer)
		currentPlayer.set_network_master(id)
		currentPlayer.connect("player_died", self, "on_player_death", [id])

	var myID = OnlineMatch.get_network_unique_id()
	OnlineMatch.custom_rpc_id_sync(self, 1, "finish_setup", [myID])

func finish_setup(id):
	GameManager.id = id
	$Game.new_game()

func on_player_death(id):
	alive_players.erase(id)
	if alive_players.size() == 0:
		emit_signal("web_game_over")

