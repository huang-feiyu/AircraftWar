extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_RegisterButton_button_down():
	var username = $InputContainer/UsernameContainer/UsernameInput.text
	var password = $InputContainer/PasswordContainer/PasswordInput.text
	var email = $InputContainer/EmailContainer/EmailInput.text

	# TODO: Pop-up window to ensure the password
	var session = yield(Online.nakama_client.authenticate_email_async(email, password, username, true), "completed")
	if session.is_exception():
		# TODO: Pop-up window to show the message
		print(session.get_exception().message)
		return
	Online.nakama_session = session
	self.hide()

func _on_LoginButton_button_down():
	var password = $InputContainer/PasswordContainer/PasswordInput.text
	var email = $InputContainer/EmailContainer/EmailInput.text

	var session = yield(Online.nakama_client.authenticate_email_async(email, password, null, false), "completed")
	if session.is_exception():
		print(session.get_exception().message)
		return
	Online.nakama_session = session
	self.hide()

