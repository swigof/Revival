extends Node2D

var page: AnimatedSprite2D
var page_above: AnimatedSprite2D
var page_below: AnimatedSprite2D
var next_page_button: Area2D
var film_effect: AnimatedSprite2D
var camera: Camera2D
const camera_home = Vector2(360, 360)
const jitter_rate = 1.0 / 24
var jitter_timer = 0
var active_page: Page

func _ready() -> void:
	get_viewport().set_physics_object_picking_first_only(true)
	get_viewport().set_physics_object_picking_sort(true)
	page = $Page
	page_above = $Page/PageAbove
	page_below = $Page/PageBelow
	next_page_button = $Page/NextPageButton
	film_effect = $FilmEffect
	camera = $Camera2D
	page_above.add_child(Cover.new())
	page_above.add_child(_create_sound_controls())

func _process(delta: float) -> void:
	jitter_timer += delta
	if jitter_timer >= jitter_rate:
		var jitter = Vector2(randf_range(-0.25, 0.25), randf_range(-0.25, 0.25))
		camera.position = camera_home + jitter
		jitter_timer = 0
		if randf() >= 0.9:
			film_effect.frame = randi() % 26
		else:
			film_effect.frame = 0

func _on_next_page_button_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_mask & MOUSE_BUTTON_LEFT:
		next_page_button.visible = false
		page.play()
		page_above.play()
		page_below.play()
		GameManager.increment_stage()
		active_page = _create_page()
		active_page.page_finished.connect(_on_page_finished)
		page_below.add_child(active_page)
		page_below.add_child(_create_sound_controls())
		page_below.add_child(_create_currency_ui())
		SoundManager.play_page_turn_sound()

func _on_page_finished() -> void:
	next_page_button.visible = true

func _on_page_animation_finished() -> void:
	page.stop()
	page_above.stop()
	page_below.stop()
	page.frame = 0
	page_above.frame = 0
	page_below.frame = 0
	for child in page_above.get_children():
		child.queue_free()
	for child in page_below.get_children():
		child.reparent(page_above)
	active_page.start()

func _create_page() -> Page:
	var stage = GameManager.get_stage()
	var next_page: Page
	if stage == "print":
		next_page = PrintingPage.new()
	elif stage == "cover":
		next_page = Cover.new()
	else:
		next_page = DialoguePage.new()
		next_page.title = stage
	return next_page

func _create_sound_controls() -> CanvasItem:
	var sound_controls_scene = load("res://src/ui/sound_controls.tscn")
	var sound_controls: Node2D = sound_controls_scene.instantiate()
	sound_controls.position.x = -280
	sound_controls.position.y = 220
	return sound_controls

func _create_currency_ui() -> CanvasItem:
	var currency_ui_scene = load("res://src/ui/currencies.tscn")
	var currency_ui = currency_ui_scene.instantiate()
	currency_ui.position.x = -365
	currency_ui.position.y = -450
	return currency_ui
