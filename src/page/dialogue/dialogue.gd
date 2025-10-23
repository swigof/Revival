class_name DialoguePage extends Page

var dialogue_resource = load("res://src/page/dialogue/dialogue.dialogue")
var title: String

func _ready() -> void:
	DialogueManager.dialogue_ended.connect(_dialogue_finished)

func _dialogue_finished(_resource: DialogueResource) -> void:
	_finish()

func start() -> void:
	DialogueManager.show_dialogue_balloon(dialogue_resource, title)
