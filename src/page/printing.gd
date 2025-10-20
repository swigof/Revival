class_name PrintingPage extends Page

var paper_scene = load("res://src/page/paper.tscn")
var paper_count = 10

func _ready() -> void:
	var label = Label.new()
	label.text = "printing"
	add_child(label)

func _on_paper_input_event(_v: Node, event: InputEvent, _s: int, source: CollisionObject2D) -> void:
	if event is InputEventMouseButton && event.button_mask & MOUSE_BUTTON_LEFT:
		source.queue_free()
		paper_count -= 1
		if paper_count <= 0:
			_finish()

func start() -> void:
	var i = 0
	while i < paper_count:
		var paper: RigidBody2D = paper_scene.instantiate()
		paper.apply_impulse(Vector2(randf_range(-2000, 2000), randf_range(-2000, 2000)))
		paper.apply_torque_impulse(randf_range(-5, 5))
		paper.get_node("Clickbox").input_event.connect(_on_paper_input_event.bind(paper))
		add_child(paper)
		i += 1
