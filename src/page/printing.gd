class_name PrintingPage extends Page

func _ready() -> void:
	var label = Label.new()
	label.text = "printing"
	add_child(label)

func start():
	pass
