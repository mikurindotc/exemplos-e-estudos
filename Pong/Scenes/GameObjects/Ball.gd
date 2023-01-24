extends RigidBody2D

signal scored(isRight)

func _on_VisibilityNotifier2D_screen_exited():
	if position.x >= get_viewport_rect().size.x:
		emit_signal("scored", true)
	elif position.x <= 0:
		emit_signal("scored", false)
	queue_free()
