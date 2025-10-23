class_name Cover extends Page

func _ready() -> void:
	var cover = Sprite2D.new()
	cover.texture = load("res://assets/title.png")
	cover.scale.x = 0.5
	cover.scale.y = 0.5
	add_child(cover)

func start() -> void:
	_finish()
