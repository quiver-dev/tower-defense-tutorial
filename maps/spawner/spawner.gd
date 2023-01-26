extends Node2D

@export_range(0.5, 5.0, 0.5) var spawn_rate: float = 2.0
@export var wave_count: int = 3
@export var enemies_per_wave_count: int = 10

@onready var wave_timer := $WaveTimer as Timer
@onready var spawn_timer := $SpawnTimer as Timer
@onready var spawn_container := $SpawnContainer as Node2D

var spawn_locations := []
var current_wave = 0
var current_enemy_count = 0

func _ready() -> void:
	for marker in spawn_container.get_children():
		spawn_locations.append(marker)
	wave_timer.start()
	
func _start_wave():
	current_wave += 1
	spawn_timer.start()
	current_enemy_count = 0
	
func _end_wave():
	if current_wave < wave_count:
		$WaveTimer.start()
	
func _spawn_new_enemy(enemy_path: String):
	var enemy: Enemy = load(enemy_path).instantiate()
	get_parent().add_child(enemy)
	var spawn_marker = spawn_locations.pick_random()
	enemy.position = spawn_marker.position
	current_enemy_count += 1

func _on_wave_timer_timeout() -> void:
	_start_wave()
		
func _on_spawn_timer_timeout() -> void:
	if current_enemy_count < enemies_per_wave_count:
		_spawn_new_enemy("res://entities/enemies/infantry/infantry_t1.tscn")
		var spawn_delay := randf_range(spawn_rate / 2, spawn_rate)
		spawn_timer.start(spawn_delay)
	else:
		_end_wave()
