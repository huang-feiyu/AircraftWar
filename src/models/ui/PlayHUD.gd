extends CanvasLayer

func _ready():
	$AttributeLabel.hide()
	$ScoreLabel.hide()
	$HPBar.hide()

func start_game():
	$AttributeLabel.show()
	$ScoreLabel.show()
	$HPBar.show()

func game_over():
	$AttributeLabel.hide()
	$ScoreLabel.hide()
	$HPBar.hide()

func update():
	$ScoreLabel.text = str(GameManager.score)
	$HPBar.value = float(GameManager.hero_hp) / float(GameManager.HERO_MAX_HP) * 100

