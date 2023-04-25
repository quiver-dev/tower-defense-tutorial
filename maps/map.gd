class_name Map
extends Node2D

signal money_changed(money: int)

@onready var objective = $Objective as Objective
@onready var camera = $Camera2D as Camera2D
@onready var spawner = $Spawner as Spawner

@export var starting_money := 5000
var money : int:
	set(m):
		money = m
		money_changed.emit(money)
var tower_costs : Dictionary

func _ready():
	var hud = $Camera2D.hud as Hud
	money_changed.connect(hud._on_money_changed)
	money = starting_money
	var tower_costs_resource = load("res://entities/towers/tower_costs_json.tres")
	tower_costs = tower_costs_resource.data
	hud.initialize(objective.health)
	objective.health_changed.connect(hud._on_objective_health_changed)
	spawner.countdown_started.connect(hud._on_spawner_countdown_started)
	spawner.wave_started.connect(hud._on_spawner_wave_started)
	spawner.enemy_spawned.connect(_on_enemy_spawned)
	
func _on_enemy_spawned(enemy: Enemy):
	enemy.enemy_died.connect(_on_enemy_died)
	
func _on_enemy_died(enemy: Enemy):
	money += enemy.kill_reward
