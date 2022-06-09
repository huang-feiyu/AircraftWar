extends CanvasLayer

func _ready():
	$AttributeLabel.hide()
	$ScoreLabel.hide()
	$RemoteScore.hide()
	$HPBar.hide()

func start_game():
	$AttributeLabel.show()
	$ScoreLabel.show()
	if not GameManager.single and GameManager.is_all_ready:
		$RemoteScore.show()
	$HPBar.show()

func game_over():
	$AttributeLabel.hide()
	$ScoreLabel.hide()
	$HPBar.hide()
	$RemoteScore.hide()

func update():
	$ScoreLabel.text = str(GameManager.score)
	$HPBar.value = float(GameManager.hero_hp) / float(GameManager.HERO_MAX_HP) * 100
	if not GameManager.single and GameManager.is_all_ready:
		$RemoteScore.text = str("Other: " + str(GameManager.opponent_score))
