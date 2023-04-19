extends Node2D

@onready var objective = $Objective as Objective
@onready var camera = $Camera2D as Camera2D
@onready var spawner = $Spawner as Spawner

@export var starting_money := 5000
var money : int

func _ready():
	money = starting_money
	var hud = $Camera2D.hud as Hud
	hud.initialize(objective.health)
	objective.health_changed.connect(hud._on_objective_health_changed)
	spawner.countdown_started.connect(hud._on_spawner_countdown_started)
	spawner.wave_started.connect(hud._on_spawner_wave_started)
