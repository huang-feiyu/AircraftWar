extends CanvasLayer

func start_game():
	$AtrributeLabel.show()
	$ScoreLabel.show()
	$HPBar.show()

func game_over():
	$AtrributeLabel.hide()
	$ScoreLabel.hide()
	$HPBar.hide()

func update_score():
	$ScoreLabel.text = str(GameManager.score)

func update_hp():
	$HPBar.value = float(GameManager.hero_hp) / float(GameManager.HERO_MAX_HP) * 100
