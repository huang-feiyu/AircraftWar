extends Node2D

var ready_players = {}

var timer_start = false

signal web_game_over

func _ready():
	login_end()

func _get_custom_rpc_methods():
	return [
		"player_is_ready",
		"update_remote_score"
	]

func _on_ReadyScreen_player_ready_signal():
	OnlineMatch.custom_rpc_sync(self, "player_is_ready", [OnlineMatch.get_my_session_id()])

func player_is_ready(id):
	$ReadyScreen.set_ready_status(id, "Ready")
	GameManager.id = id

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
		GameManager.is_game_over = true
		OnlineMatch.custom_rpc(self, "update_remote_score", [GameManager.score, true])
		print("Opponent score: ", GameManager.opponent_score)
		$MessageHUD.show_end_message()
		ready_players = {}
		GameManager.is_all_ready = false
		# OnlineMatch.leave()

func _on_MessageHUD_restart_game():
	if not GameManager.single:
		$MessageHUD.show_start_message()

func start():
	$WebLoginHUD.start()

func start_game():
	print("All Players are ready, lets start the game")
	$Game.new_game()
	login_end()
	timer_start = false
	GameManager.is_all_ready = true

func login_end():
	$WebLoginHUD.end()
	$FindMatch.end()
	$ReadyScreen.end()

func _process(delta):
	# rpc
	if not GameManager.single and GameManager.is_all_ready:
		OnlineMatch.custom_rpc(self, "update_remote_score", [GameManager.score, GameManager.is_game_over])
	if GameManager.is_game_over and not GameManager.single:
		if GameManager.opponent_alive:
			$MessageHUD.update_score()
		elif not timer_start:
			$MessageHUD/EndTimer.start(3)
			timer_start = true

func update_remote_score(score, other_game_over):
	GameManager.opponent_score = score
	GameManager.opponent_alive = not other_game_over

