extends Node

export(PackedScene) var ball_scene

func start_game():
	var ball = ball_scene.instance()
	ball.connect("scored", self, "increase_score")
	ball.position = $BallSpawn.position
	$Button.hide()
	add_child(ball)

func increase_score(isRight):
	var ball = ball_scene.instance()

func reset_game():
	var ball = ball_scene.instance()
	ball.position = $BallSpawn.position
	add_child(ball)

func _on_Button_pressed():
	start_game()
