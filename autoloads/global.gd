extends Node

signal money_changed(money: int)

var money: int:
	set(m):
		money = m
		money_changed.emit(money)
var tower_costs: Dictionary

func _ready() -> void:
	var tower_costs_resource = load("res://entities/towers/tower_costs_json.tres")
	tower_costs = tower_costs_resource.data
