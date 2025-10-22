class_name PrintingPage extends Page

var paper_scene = load("res://src/page/printing/paper.tscn")
var launched_pages = 0
var clicked_pages = 0
var started = false
var page_time_acc = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if !started:
		return
	page_time_acc += delta
	if page_time_acc > GameManager.page_launch_time && launched_pages < GameManager.page_count:
		var paper: RigidBody2D = paper_scene.instantiate()
		paper.apply_impulse(Vector2(randf_range(-2000, 2000), randf_range(-2000, 2000)))
		paper.apply_torque_impulse(randf_range(-5, 5))
		paper.get_node("Clickbox").input_event.connect(_on_paper_input_event.bind(paper))
		add_child(paper)
		SoundManager.play_paper_throw_sound()
		launched_pages += 1
		page_time_acc -= GameManager.page_launch_time

func _on_paper_input_event(_v: Node, event: InputEvent, _s: int, source: CollisionObject2D) -> void:
	if event is InputEventMouseButton && event.button_mask & MOUSE_BUTTON_LEFT:
		source.queue_free()
		clicked_pages += 1
		if clicked_pages >= GameManager.page_count:
			GameManager.apply_print_changes()
			_finish()

func start() -> void:
	started = true
