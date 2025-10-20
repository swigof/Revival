class_name DialoguePage extends Page

func _ready() -> void:
	var label = Label.new()
	label.text = "dialogue"
	add_child(label)

func start() -> void:
	_finish()
