class_name Page extends Node2D

signal page_finished

func start() -> void:
	pass

func _finish() -> void:
	page_finished.emit()
