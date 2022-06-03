extends Control

var ready
var username

func _ready():
	pass # Replace with function body.

func set_ready_status(readytext):
	$Ready.text = readytext
	ready = readytext

func set_username(usernametext):
	$UserName.text = usernametext
	username = usernametext
