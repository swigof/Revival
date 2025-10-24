extends Node

var integrity: int = 0
var wealth: int = 0
var sequence_stage = 0
var total_earnings = 0
var page_launch_time = 0.5
var book_production = 1
var quantity_modifier = 1.0
var book_value_modifiers = {"first": 1.0, "cees_rec": 1.0, "mass_market": 1.0, "local_author": 1.0}
var held_collection = false
var upgrade_tracker = {"type":0, "press":0, "distribution":0, "rights":0, "final":0}

var print_value = 0
var print_integrity = 0
var print_quantity = 0

var printed_slop = false

signal integrity_changed
signal wealth_changed

const max_integrity = 4
const max_wealth = 99999
const sequence: Array[String] = [
	"cover", "dialogue0", "print", "dialogue1", "choice_start", "print", 
	"dialogue2", "choice_start", "print", "dialogue3", "choice_start", "print", 
	"dialogue4", "choice_start", "print", "dialogue5", "end", "credits"
]
const no_ui_stages = ["cover", "credits", "end"]
const print_bases = {
	"mass_market": {
		"value": 1,
		"integrity": -1,
		"quantity": 100
	},
	"cees_rec": {
		"value": 1,
		"integrity": -2,
		"quantity": 200
	},
	"local_author": {
		"value": 2,
		"integrity": 0,
		"quantity": 20
	},
	"first": {
		"value": 2,
		"integrity": 1,
		"quantity": 20
	}
}
const upgrades = {
	"type": [
		{
			"name": "Monotype machine",
			"text": "+100% page output speed",
			"cost_wealth": 100,
			"cost_integrity": 0,
			"value": 0.25
		},
		{
			"name": "Linotype machine",
			"text": "+100% page output speed",
			"cost_wealth": 100,
			"cost_integrity": 0,
			"value": 0.125
		}
	],
	"press": [
		{
			"name": "Koenig press",
			"text": "+100% book production",
			"cost_wealth": 100,
			"cost_integrity": 0,
			"value": 2
		},
		{
			"name": "Cylinder press",
			"text": "+100% book production",
			"cost_wealth": 100,
			"cost_integrity": 0,
			"value": 4
		}
	],
	"distribution": [
		{
			"name": "Bookstore partnership",
			"text": "+50% print run size",
			"cost_wealth": 100,
			"cost_integrity": 0,
			"value": 1.5
		},
		{
			"name": "Drugstore partnership",
			"text": "+100% print run size",
			"cost_wealth": 100,
			"cost_integrity": 1,
			"value": 3.0
		}
	],
	"rights": [
		{
			"name": "Expanded author network",
			"text": "+50% book value",
			"cost_wealth": 100,
			"cost_integrity": 0,
			"value": 1.5
		},
		{
			"name": "Expanded mass market book rights",
			"text": "+50% mass market book value",
			"cost_wealth": 100,
			"cost_integrity": 1,
			"value": 1.5
		},
	],
	"final": [
		{
			"name": "Lithographic offset press",
			"text": "+900% print run size \n +100% page output speed \n Allow held down page collection",
			"cost_wealth": 100,
			"cost_integrity": 2,
			"value": true
		}
	]
}

func get_upgrade_text(upgrade_type: String) -> String:
	if upgrade_type == "final" && !_is_at_final():
		return "[#hide]"
	var upgrade_stages = upgrades[upgrade_type]
	var upgrade_index = upgrade_tracker[upgrade_type]
	if len(upgrade_stages) <= upgrade_index:
		return "[#hide]"
	var upgrade = upgrade_stages[upgrade_index]
	var text = ""
	if upgrade.cost_wealth > wealth:
		text += "[#disable]"
	text += upgrade.name + " \n "
	if upgrade.cost_integrity != 0:
		text += "-" + str(upgrade.cost_integrity) + " integrity | "
	text += "-" + str(upgrade.cost_wealth) + "$ \n "
	text += upgrade.text
	return text

func _is_at_final() -> bool:
	return upgrade_tracker["type"] == len(upgrades["type"]) \
		&& upgrade_tracker["press"] == len(upgrades["press"]) \
		&& upgrade_tracker["distribution"] == len(upgrades["distribution"]) \
		&& upgrade_tracker["rights"] == len(upgrades["rights"])

func get_print_text(option: String) -> String:
	var print_base = print_bases[option]
	var option_value = print_base.value * book_value_modifiers[option]
	var option_integrity = print_base.integrity
	var option_quantity = int(print_base.quantity * quantity_modifier)
	var text = str(option_quantity) + " copies \n "
	if option_integrity != 0:
		if option_integrity > 0:
			text += "+"
		text += str(option_integrity) + " integrity | "
	text += "+" + str(option_value) + "$ per book"
	return text

func purchase_upgrade(upgrade_type: String) -> void:
	var upgrade_index = upgrade_tracker[upgrade_type]
	var upgrade_stages = upgrades[upgrade_type]
	if len(upgrade_stages) <= upgrade_index:
		return
	var upgrade = upgrade_stages[upgrade_index]
	if upgrade_type == "type":
		page_launch_time = upgrade.value
	elif upgrade_type == "press":
		book_production = upgrade.value
	elif upgrade_type == "distribution":
		quantity_modifier = upgrade.value
	elif upgrade_type == "rights":
		if upgrade_index == 0:
			book_value_modifiers["cees_rec"] = upgrade.value
			book_value_modifiers["mass_market"] = upgrade.value
			book_value_modifiers["local_author"] = upgrade.value
		else:
			book_value_modifiers["mass_market"] = upgrade.value
	elif upgrade_type == "final":
		quantity_modifier *= 10
		page_launch_time = page_launch_time / 2
		held_collection = true
	update_wealth(-upgrade.cost_wealth)
	update_integrity(-upgrade.cost_integrity)
	upgrade_tracker[upgrade_type] += 1

func set_print(option: String) -> void:
	var print_base = print_bases[option]
	print_value = print_base["value"] * book_value_modifiers[option]
	print_integrity = print_base["integrity"]
	print_quantity = int(print_base["quantity"] * quantity_modifier)

func reset_game() -> void:
	integrity = 0
	wealth = 0
	sequence_stage = 0
	total_earnings = 0
	page_launch_time = 0.5
	print_value = 0
	print_integrity = 0
	print_quantity = 0
	printed_slop = false
	book_production = 1
	quantity_modifier = 1.0
	book_value_modifiers = {"first": 1.0, "cees_rec": 1.0, "mass_market": 1.0, "local_author": 1.0}
	held_collection = false
	upgrade_tracker = {"type":0, "press":0, "distribution":0, "rights":0, "final":0}

func get_stage() -> String:
	return sequence[sequence_stage]
	
func increment_stage() -> String:
	sequence_stage += 1
	if sequence_stage >= len(sequence):
		sequence_stage = 0
	return get_stage()

func apply_print_changes(emit: bool = true) -> void:
	update_wealth(print_value * print_quantity, emit)
	update_integrity(print_integrity, emit)
	print_value = 0
	print_integrity = 0
	print_quantity = 0

func update_wealth(amount: int, emit: bool = true) -> void:
	if amount == 0:
		return
	if amount > 0:
		total_earnings += amount
	wealth += amount
	if wealth > max_wealth:
		wealth = max_wealth
	elif wealth < 0:
		wealth = 0
	if emit:
		wealth_changed.emit()

func update_integrity(amount: int, emit: bool = true) -> void:
	if amount == 0:
		return
	integrity += amount
	if integrity > max_integrity:
		integrity = max_integrity
	elif integrity < 0:
		integrity = 0
	if emit:
		integrity_changed.emit()
