extends Node

var integrity: int = 0
var wealth: int = 0
var page_count = 10
var page_launch_time = 0.1

var next_print_wealth = 0
var next_print_integrity = 0

signal integrity_changed
signal wealth_changed

const max_integrity = 4
const max_wealth = 99999

func apply_print_changes() -> void:
	update_wealth(next_print_wealth)
	update_integrity(next_print_integrity)
	next_print_wealth = 0
	next_print_integrity = 0

func update_wealth(amount: int) -> void:
	if amount == 0:
		return
	wealth += amount
	if wealth > max_wealth:
		wealth = max_wealth
	elif wealth < 0:
		wealth = 0
	wealth_changed.emit()

func update_integrity(amount: int) -> void:
	if amount == 0:
		return
	integrity += amount
	if integrity > max_integrity:
		integrity = max_integrity
	elif integrity < 0:
		integrity = 0
	integrity_changed.emit()
