extends AnimatedSprite2D

var page_above: AnimatedSprite2D
var page_below: AnimatedSprite2D

func _ready() -> void:
	page_above = get_node("PageAbove")
	page_below = get_node("PageBelow")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		if event.button_mask & MOUSE_BUTTON_LEFT:
			play()
			page_above.play()
			page_below.play()

func _on_page_animation_finished() -> void:
	stop()
	page_above.stop()
	page_below.stop()
	frame = 0
	page_above.frame = 0
	page_below.frame = 0
	
