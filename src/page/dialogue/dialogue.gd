class_name DialoguePage extends Page

static var dialogue_number = 0

var dialogue_resource = load("res://src/page/dialogue/dialogue.dialogue")
var titles: PackedStringArray

func _ready() -> void:
	titles = dialogue_resource.get_titles()
	DialogueManager.dialogue_ended.connect(_dialogue_finished)

func _dialogue_finished(_resource: DialogueResource) -> void:
	_finish()

func start() -> void:
	var title = "dialogue" + str(dialogue_number)
	if title in titles:
		DialogueManager.show_dialogue_balloon(dialogue_resource, title)
		dialogue_number += 1
