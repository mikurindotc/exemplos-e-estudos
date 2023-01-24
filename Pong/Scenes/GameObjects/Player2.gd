extends Area2D

signal hit

export var speed = 600
var player_height = 144
var screen_size
var velocity
var score
var clampMin = 0 + (player_height/2) + 40
var clampMax

func _ready():
	screen_size = get_viewport_rect().size
	clampMax = screen_size.y - (player_height/2) - 40
	
func _process(delta):
	velocity = Vector2.ZERO
	move_player()
	clamp_move(delta)

func move_player():
	if Input.is_action_pressed("move_up_p2"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down_p2"):
		velocity.y += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

func clamp_move(delta):
	position += velocity * delta
	position.y = clamp(position.y, clampMin, clampMax)

func _on_Area2D_body_entered(_body):
	emit_signal("hit")
