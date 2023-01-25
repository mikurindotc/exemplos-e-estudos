extends Node

export(PackedScene) var ball_scene
var ball
var ball_speed = 400
var score_p1
var score_p2

func _ready():
	randomize()

func start_game():
	score_p1 = 0
	score_p2 = 0
	reset_game()
	$Button.hide()

func increase_score(isRight):
	if isRight:
		score_p1 += 1
		$UI.update_score_p1(score_p1)
	else:
		score_p2 += 1
		$UI.update_score_p2(score_p2)
	reset_game()

func reset_game():
	init_ball()
	$BallRespawnTimer.start()

func init_ball():
	ball = ball_scene.instance()
	ball.position = $BallSpawn.position
	ball.connect("scored", self, "increase_score")
	add_child(ball)

func start_ball_move():
	ball.linear_velocity.x = ball_speed if randi() % 2 == 0 else -ball_speed
	ball.linear_velocity = ball.linear_velocity.rotated(rand_range(-PI / 4, PI / 4))

func _on_Button_pressed():
	start_game()

func _on_Player1_hit():
	var yAbs = abs(ball.linear_velocity.y)
	ball.linear_velocity.x *= -1
	ball.linear_velocity.y = yAbs if ball.position.y > $Player1.position.y else -yAbs
	ball.linear_velocity = ball.linear_velocity.rotated(rand_range(-PI / 8, PI / 8))

func _on_Player2_hit():
	var yAbs = abs(ball.linear_velocity.y)
	ball.linear_velocity.x *= -1
	ball.linear_velocity.y = yAbs if ball.position.y > $Player2.position.y else -yAbs
	ball.linear_velocity = ball.linear_velocity.rotated(rand_range(-PI / 8, PI / 8))

func _on_WallUp_body_entered(_body):
	ball.linear_velocity.y *= -1

func _on_WallDown_body_entered(_body):
	ball.linear_velocity.y *= -1

func _on_BallRespawnTimer_timeout():
	start_ball_move()
	$BallRespawnTimer.stop()
