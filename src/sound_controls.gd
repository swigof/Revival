extends Node2D

static var sfx_enabled = true
static var music_enabled = true

func _set_sfx_icon() -> void:
	if sfx_enabled:
		$SFXButton/SFXIcon.texture = load("res://assets/icons/speaker.png")
	else:
		$SFXButton/SFXIcon.texture = load("res://assets/icons/speaker-off.png")

func _set_music_icon() -> void:
	if music_enabled:
		$MusicButton/MusicIcon.texture = load("res://assets/icons/sound-on.png")
	else:
		$MusicButton/MusicIcon.texture = load("res://assets/icons/sound-off.png")

func _ready() -> void:
	_set_sfx_icon()
	_set_music_icon()

func _on_sfx_button_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_mask & MOUSE_BUTTON_LEFT:
		sfx_enabled = !sfx_enabled
		AudioServer.set_bus_mute(1, !sfx_enabled)
		_set_sfx_icon()

				
func _on_music_button_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton && event.button_mask & MOUSE_BUTTON_LEFT:
		music_enabled = !music_enabled
		AudioServer.set_bus_mute(2, !music_enabled)
		_set_music_icon()
