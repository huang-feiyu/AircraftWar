extends Node2D

func _get_custom_rpc_methods():
	return [
		"player_is_ready"
	]

func _ready():
	pass # Replace with function body.

func _on_ReadyScreen_player_ready_signal():
	OnlineMatch.custom_rpc_sync(self, "player_is_ready", [OnlineMatch.get_my_session_id()])

func player_is_ready(id):
	$ReadyScreen.set_ready_status(id, "Ready")

