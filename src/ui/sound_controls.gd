extends Node2D

func _ready() -> void:
	_set_sfx_icon()
	_set_music_icon()
	SoundController.sfx_toggled.connect(_set_sfx_icon)
	SoundController.music_toggled.connect(_set_music_icon)

func _set_sfx_icon() -> void:
	if SoundController.sfx_enabled:
		$SFXButton/SFXIcon.texture = load("res://assets/icons/speaker.png")
	else:
		$SFXButton/SFXIcon.texture = load("res://assets/icons/speaker-off.png")

func _set_music_icon() -> void:
	if SoundController.music_enabled:
		$MusicButton/MusicIcon.texture = load("res://assets/icons/sound-on.png")
	else:
		$MusicButton/MusicIcon.texture = load("res://assets/icons/sound-off.png")

func _on_sfx_button_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_mask & MOUSE_BUTTON_LEFT:
		SoundController.toggle_sfx()

func _on_music_button_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_mask & MOUSE_BUTTON_LEFT:
		SoundController.toggle_music()
