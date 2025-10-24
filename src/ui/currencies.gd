extends Node

func _ready() -> void:
	_update_wealth()
	_update_integrity_orbs()
	GameManager.wealth_changed.connect(_update_wealth)
	GameManager.integrity_changed.connect(_update_integrity_orbs)

func _update_wealth() -> void:
	$Wealth.text = str(GameManager.wealth) + "$"

func _update_integrity_orbs() -> void:
	var i = 0
	for integrity_orb: TextureRect in $Integrity.get_children():
		if i < GameManager.integrity:
			integrity_orb.texture = load("res://src/ui/integrity_filled.tres")
		else:
			integrity_orb.texture = load("res://src/ui/integrity_empty.tres")
		i += 1
