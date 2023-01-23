extends Area2D

signal hit

export var speed = 400
var screen_size

var velocity

func velocityCalculate(x, y):
	velocity = Vector2(x, y).normalized() * speed

func positionCalculate(dt):
	position += velocity * dt
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	#hide()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var axisX = 0
	var axisY = 0
	
	#var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		axisX += 1
	if Input.is_action_pressed("move_left"):
		axisX += -1
	if Input.is_action_pressed("move_down"):
		axisY += 1
	if Input.is_action_pressed("move_up"):
		axisY += -1

	velocityCalculate(axisX, axisY)

	if velocity.length() > 0:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	# Move in the given direction.
	
	positionCalculate(delta)
	
	#Play the appropriate animation.
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0

func _on_Player_body_entered(_body):
	hide() # Player disappears after being hit.
	emit_signal("hit")
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
