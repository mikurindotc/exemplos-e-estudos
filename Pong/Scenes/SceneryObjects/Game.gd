extends Node

export(PackedScene) var ball_scene
var ball

func _ready():
	ball = ball_scene.instance()

func start_game():
	ball.connect("scored", self, "increase_score")
	ball.position = $BallSpawn.position
	$Button.hide()
	add_child(ball)

func increase_score(isRight):
	#TO DO
	pass
	
func reset_game():
	ball = ball_scene.instance()
	ball.position = $BallSpawn.position
	add_child(ball)

func _on_Button_pressed():
	start_game()


func _on_Player1_hit():
	ball.linear_velocity.x *= -1
	print(ball.linear_velocity.x)

func _on_Player2_hit():
	ball.linear_velocity.x *= -1
	print(ball.linear_velocity.x)
