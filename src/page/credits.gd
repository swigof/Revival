class_name Credits extends Page

func _ready() -> void:
	var label = Label.new()
	label.text = "
		Based on the film The Animal Kingdom (1932)

		Niconne Regular font by Vernon Adams
		EB Garamond font by Georg Duffner & Octavio Pardo
		Libre Caslon Text font by Impallari Type
		All licensed under the SIL Open Font License 1.1
		
		Audio Icons by Delapouite on game-icons.net
		Arrow by Felbrigg on game-icons.net
		Both licensed under CC BY 3.0

		film grime overlay by jamal studio on Vecteezy
		
		Featuring the music \"Lonely\" by Leo Reisman & His Orchestra

		Dialogue Manager Godot plugin by Nathan Hoad licensed under the MIT License

		Everything else by swigof
		
		Made with Godot, Audacity, GIMP and DaVinci Resolve
	"
	label.position.x = -340
	label.position.y = -360
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	add_child(label)
	pass

func start() -> void:
	_finish()
