extends Node2D

var paper_throw_player = AudioStreamPlayer.new()
var paper_throw_sounds = AudioStreamRandomizer.new()

func _ready() -> void:
	add_child(paper_throw_player)
	paper_throw_player.set_max_polyphony(100)
	paper_throw_player.set_bus(&"SFX")
	paper_throw_player.set_stream(paper_throw_sounds)
	var path = "res://assets/paper-throws-flapping"
	var dir = DirAccess.open(path)
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			break
		elif !file_name.ends_with(".import"):
			paper_throw_sounds.add_stream(-1, load(path + "/" + file_name))

func play_paper_throw_sound() -> void:
	paper_throw_player.play()
