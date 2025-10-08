extends AnimatedSprite2D

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		if event.button_mask & MOUSE_BUTTON_LEFT:
			play()
