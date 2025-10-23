class_name PrintingPage extends Page

var paper_scene = load("res://src/page/printing/paper.tscn")
var launched_pages = 0
var clicked_pages = 0
var started = false
var page_time_acc = 0
var progress_label = Label.new()
var page_container = Container.new()

func _ready() -> void:
	progress_label.text = "0 / " + str(GameManager.print_quantity)
	progress_label.position.x = -360
	progress_label.position.y = 200
	progress_label.custom_minimum_size = Vector2(720, 720)
	progress_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	progress_label.add_theme_font_size_override("font_size", 25)
	add_child(page_container)
	add_child(progress_label)

func _process(delta: float) -> void:
	if !started:
		return
	page_time_acc += delta
	if page_time_acc < GameManager.page_launch_time:
		return
	if launched_pages < GameManager.print_quantity:
		var paper: RigidBody2D = paper_scene.instantiate()
		paper.apply_impulse(Vector2(randf_range(-2000, 2000), randf_range(-2000, 2000)))
		paper.apply_torque_impulse(randf_range(-5, 5))
		paper.get_node("Clickbox").input_event.connect(_on_paper_input_event.bind(paper))
		page_container.add_child(paper)
		SoundManager.play_paper_throw_sound()
		launched_pages += 1
		page_time_acc -= GameManager.page_launch_time

func _on_paper_input_event(_v: Node, event: InputEvent, _s: int, source: CollisionObject2D) -> void:
	if event is InputEventMouseButton && event.button_mask & MOUSE_BUTTON_LEFT:
		source.queue_free()
		clicked_pages += 1
		progress_label.text = str(clicked_pages) + " / " + str(GameManager.print_quantity)
		if clicked_pages >= GameManager.print_quantity:
			_finish()

func start() -> void:
	started = true
