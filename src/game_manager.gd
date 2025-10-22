extends Node

var integrity: int = 0
var wealth: int = 0
var page_count = 10
var page_launch_time = 0.1

signal integrity_changed
signal wealth_changed

const max_integrity = 4
const max_wealth = 99999

func add_wealth(amount: int) -> void:
	if amount <= 0:
		return
	wealth += amount
	if wealth > max_wealth:
		wealth = max_wealth
	wealth_changed.emit()

func remove_wealth(amount: int) -> void:
	if amount <= 0:
		return
	wealth -= amount
	if wealth < 0:
		wealth = 0
	wealth_changed.emit()

func add_integrity(amount: int) -> void:
	if amount <= 0:
		return
	integrity += amount
	if integrity > max_integrity:
		integrity = max_integrity
	integrity_changed.emit()

func remove_integrity(amount: int) -> void:
	if amount <= 0:
		return
	integrity -= amount
	if integrity < 0:
		integrity = 0
	integrity_changed.emit()
