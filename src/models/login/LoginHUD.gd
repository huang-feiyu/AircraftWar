extends CanvasLayer

signal login_done

func _ready():
	$Panel.hide()
	$InputContainer.hide()
	$PasswordConfirm.hide()

func _on_Button_button_down():
	set_dialog_text("Password: " + $InputContainer/PasswordContainer/PasswordInput.get_text())
	validate_input()

func _on_PasswordConfirm_confirmed():
	if not validate_input():
		return
	if $Sqlite.read_account_from_db($InputContainer/AccountContainer/AccountInput.get_text(),\
									$InputContainer/PasswordContainer/PasswordInput.get_text()):
		$PasswordConfirm.hide()
		end()
	else:
		set_dialog_text("Wrong Password")

func start():
	$InputContainer.show()
	$Panel.show()

func end():
	$InputContainer.hide()
	$Panel.hide()
	emit_signal("login_done")
	GameManager.user_name = $InputContainer/AccountContainer/AccountInput.get_text()

func set_dialog_text(text):
	$PasswordConfirm.hide()
	$PasswordConfirm.window_title = "Ensure your password"
	$PasswordConfirm.dialog_text = text
	$PasswordConfirm.show()

func validate_input():
	var name_regex = RegEx.new()
	name_regex.compile("^[a-zA-Z0-9]{4,15}$")
	var psw_regex = RegEx.new()
	psw_regex.compile("^.{6,}$")
	if not name_regex.search($InputContainer/AccountContainer/AccountInput.get_text()):
		$PasswordConfirm.window_title = "Invalid Account Name"
		set_dialog_text("Name must be 4-15 characters long and only contain letters and numbers")
		return false
	elif not psw_regex.search($InputContainer/PasswordContainer/PasswordInput.get_text()):
		$PasswordConfirm.window_title = "Invalid Password"
		set_dialog_text("Password must be at least 6 characters long")
		return false

	return true
