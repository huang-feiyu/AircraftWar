extends CanvasLayer

signal login_done

func _ready():
	$InputContainer.hide()
	$PasswordConfirm.hide()
	start()

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

func end():
	$InputContainer.hide()
	emit_signal("login_done")
	GameManager.user_name = $InputContainer/AccountContainer/AccountInput.get_text()

func set_dialog_text(text):
	$PasswordConfirm.hide()
	$PasswordConfirm.dialog_text = text
	$PasswordConfirm.show()

func validate_input():
	var name_regex = RegEx.new()
	name_regex.compile("^[a-zA-Z0-9]{4,15}$")
	var psw_regex = RegEx.new()
	psw_regex.compile("^.{6,}$")
	if not name_regex.search($InputContainer/AccountContainer/AccountInput.get_text()):
		set_dialog_text("Invalid Name")
		return false
	elif not psw_regex.search($InputContainer/PasswordContainer/PasswordInput.get_text()):
		set_dialog_text("Invalid Password")
		return false

	return true
