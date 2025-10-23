class_name EndPage extends Page

func _ready() -> void:
	var label = Label.new()
	label.text = "THE\nEND"
	label.position.x = -360
	label.position.y = -360
	label.custom_minimum_size = Vector2(720, 720)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.add_theme_font_override("font", load("res://assets/fonts/Niconne-Regular.ttf"))
	label.add_theme_font_size_override("font_size", 200)
	add_child(label)

func start() -> void:
	get_tree().create_timer(1).timeout.connect(on_timeout)

func on_timeout() -> void:
	_finish()
