extends Node2D

var score = 0
var is_sent = false

signal player_died()

func _get_custom_rpc_methods():
	return [
		"update_remote_players"
	]

func _process(delta):
	score = GameManager.score
	OnlineMatch.custom_rpc(self, "update_remote_players", [score])
	if GameManager.hero_hp <= 0 and not is_sent:
		emit_signal("player_died")
		is_sent = true

func update_remote_players(current_score):
	GameManager.opponent_score = current_score
	print("Oppenent score: " + str(GameManager.opponent_score))
