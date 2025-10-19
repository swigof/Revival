class_name ChoicePage extends Node2D

func _ready() -> void:
	var label = Label.new()
	label.text = "choice"
	add_child(label)
