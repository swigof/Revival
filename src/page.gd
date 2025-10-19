extends AnimatedSprite2D

var page_above: AnimatedSprite2D
var page_below: AnimatedSprite2D
var rng = RandomNumberGenerator.new()
const page_home = Vector2(363, 452)
const jitter_rate = 1.0 / 24
var jitter_timer = 0

func _ready() -> void:
	page_above = $PageAbove
	page_below = $PageBelow
	var first_page = Sprite2D.new()
	first_page.texture = load("res://assets/title.png")
	first_page.scale.x = 0.5
	first_page.scale.y = 0.5
	page_above.add_child(first_page)
	page_above.add_child(_create_sound_controls())

func _process(delta: float) -> void:
	jitter_timer += delta
	if jitter_timer >= jitter_rate:
		var jitter = Vector2(randf_range(-0.25, 0.25), rng.randf_range(-0.25, 0.25))
		position = page_home + jitter
		jitter_timer = 0
		if randf() >= 0.9:
			$FilmEffect.frame = randi() % 26
		else:
			$FilmEffect.frame = 0

func _on_next_page_button_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_mask & MOUSE_BUTTON_LEFT:
		$NextPageButton.visible = false
		play()
		page_above.play()
		page_below.play()
		page_below.add_child(_create_sound_controls())

func _on_page_animation_finished() -> void:
	$NextPageButton.visible = true
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

func _create_sound_controls() -> CanvasItem:
	var sound_controls_scene = load("res://src/sound_controls.tscn")
	var sound_controls: Node2D = sound_controls_scene.instantiate()
	sound_controls.position.x = -290
	sound_controls.position.y = 230
	return sound_controls
