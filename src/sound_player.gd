extends Node2D

var paper_throw_player = AudioStreamPlayer.new()
var paper_throw_sounds = AudioStreamRandomizer.new()

var page_turn_player = AudioStreamPlayer.new()
var page_turn_sounds = AudioStreamRandomizer.new()

func _ready() -> void:
	add_child(paper_throw_player)
	paper_throw_player.set_max_polyphony(100)
	paper_throw_player.set_bus(&"SFX")
	paper_throw_player.set_stream(paper_throw_sounds)
	var path = "res://assets/paper-throws-flapping"
	var file_names = ResourceLoader.list_directory(path)
	for file_name in file_names:
		if file_name.ends_with(".mp3"):
			paper_throw_sounds.add_stream(-1, load(path + "/" + file_name))
			
	add_child(page_turn_player)
	page_turn_player.set_bus(&"SFX")
	page_turn_player.set_stream(page_turn_sounds)
	path = "res://assets/page-turns"
	file_names = ResourceLoader.list_directory(path)
	for file_name in file_names:
		if file_name.ends_with(".mp3"):
			page_turn_sounds.add_stream(-1, load(path + "/" + file_name))

func play_paper_throw_sound() -> void:
	paper_throw_player.play()

func play_page_turn_sound() -> void:
	page_turn_player.play()
