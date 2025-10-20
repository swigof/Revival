extends AnimatedSprite2D

var page_above: AnimatedSprite2D
var page_below: AnimatedSprite2D
var next_page_button: Area2D
var film_effect: AnimatedSprite2D
const page_home = Vector2(363, 452)
const jitter_rate = 1.0 / 24
var jitter_timer = 0
var active_page: Page

func _ready() -> void:
	get_viewport().set_physics_object_picking_first_only(true)
	get_viewport().set_physics_object_picking_sort(true)
	page_above = $PageAbove
	page_below = $PageBelow
	next_page_button = $NextPageButton
	film_effect = $FilmEffect
	var first_page = Sprite2D.new()
	first_page.texture = load("res://assets/title.png")
	first_page.scale.x = 0.5
	first_page.scale.y = 0.5
	page_above.add_child(first_page)
	page_above.add_child(_create_sound_controls())

func _process(delta: float) -> void:
	jitter_timer += delta
	if jitter_timer >= jitter_rate:
		var jitter = Vector2(randf_range(-0.25, 0.25), randf_range(-0.25, 0.25))
		position = page_home + jitter
		jitter_timer = 0
		if randf() >= 0.9:
			film_effect.frame = randi() % 26
		else:
			film_effect.frame = 0

func _on_next_page_button_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_mask & MOUSE_BUTTON_LEFT:
		next_page_button.visible = false
		play()
		page_above.play()
		page_below.play()
		active_page = _create_page()
		active_page.page_finished.connect(_on_page_finished)
		page_below.add_child(active_page)
		page_below.add_child(_create_sound_controls())

func _on_page_finished() -> void:
	next_page_button.visible = true

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
	active_page.start()

func _create_page() -> Page:
	if active_page is DialoguePage:
		return ChoicePage.new()
	elif active_page is PrintingPage:
		return DialoguePage.new()
	else:
		return PrintingPage.new()

func _create_sound_controls() -> CanvasItem:
	var sound_controls_scene = load("res://src/sound_controls.tscn")
	var sound_controls: Node2D = sound_controls_scene.instantiate()
	sound_controls.position.x = -290
	sound_controls.position.y = 230
	return sound_controls
