class_name DialoguePage extends Node2D

func _ready() -> void:
	var label = Label.new()
	label.text = "dialogue"
	add_child(label)
