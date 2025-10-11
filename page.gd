extends AnimatedSprite2D

var page_above: AnimatedSprite2D
var page_below: AnimatedSprite2D
var count: int = 0

func _create_sound_controls() -> Node2D:
	var sound_controls_scene = load("res://src/sound_controls.tscn")
	var sound_controls: Node2D = sound_controls_scene.instantiate()
	sound_controls.position.x = -250
	sound_controls.position.y = 200
	return sound_controls

func _ready() -> void:
	page_above = get_node("PageAbove")
	page_below = get_node("PageBelow")
	var first_page = Sprite2D.new()
	first_page.texture = load("res://assets/title.png")
	first_page.scale.x = 0.5
	first_page.scale.y = 0.5
	page_above.add_child(first_page)
	page_above.add_child(_create_sound_controls())

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		if event.button_mask & MOUSE_BUTTON_LEFT && !is_playing():
			play()
			page_above.play()
			page_below.play()
			count += 1
			var label = Label.new()
			label.text = str(count)
			page_below.add_child(label)
			page_below.add_child(_create_sound_controls())

func _on_page_animation_finished() -> void:
	stop()
	page_above.stop()
	page_below.stop()
	frame = 0
	page_above.frame = 0
	page_below.frame = 0
	for child in page_above.get_children():
		child.queue_free()
	for child in page_below.get_children():
		child.reparent(page_above)
