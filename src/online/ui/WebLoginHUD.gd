extends CanvasLayer

signal weblogin_done()

# Called when the node enters the scene tree for the first time.
func _ready():
	end()

func _on_RegisterButton_button_down():
	var username = $InputContainer/UsernameContainer/UsernameInput.text
	var password = $InputContainer/PasswordContainer/PasswordInput.text
	var email = $InputContainer/EmailContainer/EmailInput.text

	var session = yield(Online.nakama_client.authenticate_email_async(email, password, username, true), "completed")
	if session.is_exception():
		set_dialog_text(session.get_exception().message)
		print("Register: ", session.get_exception().message)
		return
	set_dialog_text("Password: " + $InputContainer/PasswordContainer/PasswordInput.text)
	Online.nakama_session = session
	emit_signal("weblogin_done")
	print("emit weblogin_done")
	end()

func _on_LoginButton_button_down():
	var password = $InputContainer/PasswordContainer/PasswordInput.text
	var email = $InputContainer/EmailContainer/EmailInput.text

	var session = yield(Online.nakama_client.authenticate_email_async(email, password, null, false), "completed")
	if session.is_exception():
		set_dialog_text(session.get_exception().message)
		print("Login: ", session.get_exception().message)
		return
	Online.nakama_session = session
	emit_signal("weblogin_done")
	print("emit weblogin_done")
	end()

func _on_PasswordConfirm_confirmed():
	$PasswordConfirm.hide()

func start():
	$InputContainer.show()
	$Panel.show()

func end():
	$Panel.hide()
	$InputContainer.hide()
	$PasswordConfirm.hide()

func set_dialog_text(text):
	$PasswordConfirm.hide()
	$PasswordConfirm.window_title = "Something went wrong"
	$PasswordConfirm.dialog_text = text
	$PasswordConfirm.show()

