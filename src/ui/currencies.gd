extends Node

static var integrity: int = 0
static var wealth: int = 0

const max_integrity = 4
const max_wealth = 99999

func _ready() -> void:
	_update_wealth()
	_update_integrity_orbs()
	
func add_wealth(amount: int) -> void:
	if amount <= 0:
		return
	wealth += amount
	if wealth > max_wealth:
		wealth = max_wealth
	_update_wealth()

func remove_wealth(amount: int) -> void:
	if amount <= 0:
		return
	wealth -= amount
	if wealth < 0:
		wealth = 0
	_update_wealth()
	
func add_integrity(amount: int) -> void:
	if amount <= 0:
		return
	integrity += amount
	if integrity > max_integrity:
		integrity = max_integrity
	_update_integrity_orbs()
	
func remove_integrity(amount: int) -> void:
	if amount <= 0:
		return
	integrity -= amount
	if integrity < 0:
		integrity = 0
	_update_integrity_orbs()

func _update_wealth() -> void:
	$Wealth.text = str(wealth) + "$"

func _update_integrity_orbs() -> void:
	var i = 0
	for integrity_orb: TextureRect in $Integrity.get_children():
		if i < integrity:
			integrity_orb.texture = load("res://src/ui/integrity_filled.tres")
		else:
			integrity_orb.texture = load("res://src/ui/integrity_empty.tres")
		i += 1
