class_name PrintingPage extends Node2D

func _ready() -> void:
	var label = Label.new()
	label.text = "printing"
	add_child(label)
