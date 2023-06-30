extends Node2D

@export var starting_money := 5000

@onready var tilemap := $TileMap as TileMap
@onready var camera := $Camera2D as Camera2D
@onready var objective := $Objective as Objective
@onready var spawner := $Spawner as Spawner

func _ready():
	# initialize camera
	var map_limits := tilemap.get_used_rect()
	var tile_size := tilemap.tile_set.tile_size
	camera.limit_left = map_limits.position.x * tile_size.x
	camera.limit_top = map_limits.position.y * tile_size.y
	camera.limit_right = map_limits.end.x * tile_size.x
	camera.limit_bottom = map_limits.end.y * tile_size.y
	# initialize money and connect signals
	var hud = camera.hud as HUD
	Global.money_changed.connect(hud._on_money_changed)
	Global.money = starting_money
	hud.initialize(objective.health)
	objective.health_changed.connect(hud._on_objective_health_changed)
	objective.objective_destroyed.connect(_on_objective_destroyed)
	spawner.countdown_started.connect(hud._on_spawner_countdown_started)
	spawner.wave_started.connect(hud._on_spawner_wave_started)
	spawner.enemy_spawned.connect(_on_enemy_spawned)
	spawner.enemies_defeated.connect(_on_enemies_defeated)

	
func _on_enemy_spawned(enemy: Enemy):
	enemy.enemy_died.connect(_on_enemy_died)


func _on_enemy_died(enemy: Enemy):
	Global.money += enemy.kill_reward


func _game_over():
	var hud = camera.hud as HUD
	hud.get_node("Menus/GameOver").enable()
	# Prevent pausing during game over screen
	hud.get_node("Menus/Pause").queue_free()


func _on_objective_destroyed():
	_game_over()


func _on_enemies_defeated():
	_game_over()
