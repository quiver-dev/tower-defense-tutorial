class_name Spawner
extends Node2D

signal countdown_started(seconds: float)
signal wave_started(current_wave: int)
signal enemy_spawned(enemy: Enemy)
signal enemies_defeated

@export_range(0.5, 5.0, 0.5) var spawn_rate: float = 2.0
@export var wave_count: int = 3
@export var enemies_per_wave_count: int = 10
@export var spawn_probabilities := {
	"infantry": 50,
	"infantry2": 30,
	"tank": 20,
	"helicopter": 5,
}


var enemy_scenes := {
	"infantry": preload("res://entities/enemies/infantry/infantry_t1.tscn"),
	"infantry2": preload("res://entities/enemies/infantry/infantry_t2.tscn"),
	"tank": preload("res://entities/enemies/tanks/tank.tscn"),
	"helicopter": preload("res://entities/enemies/helicopters/helicopter.tscn"),
}
var spawn_locations := []
var current_wave := 0
var current_enemy_count := 0
var _enemy_removed_count := 0

@onready var wave_timer := $WaveTimer as Timer
@onready var spawn_timer := $SpawnTimer as Timer
@onready var spawn_container := $SpawnContainer as Node2D

func _ready() -> void:
	for marker in spawn_container.get_children():
		spawn_locations.append(marker)
	wave_timer.start()
	await owner.ready
	countdown_started.emit(wave_timer.time_left)


func _start_wave():
	current_wave += 1
	spawn_timer.start()
	current_enemy_count = 0
	wave_started.emit(current_wave)


func _end_wave():
	if current_wave < wave_count:
		wave_timer.start()
		countdown_started.emit(wave_timer.time_left)


func _spawn_new_enemy(enemy_name: String):
	var enemy: Enemy = enemy_scenes[enemy_name].instantiate()
	get_parent().add_child(enemy)
	var spawn_marker = spawn_locations.pick_random()
	enemy.global_position = spawn_marker.global_position
	current_enemy_count += 1
	enemy_spawned.emit(enemy)
	enemy.enemy_removed.connect(_on_enemy_removed)


func _on_wave_timer_timeout() -> void:
	_start_wave()


func _on_spawn_timer_timeout() -> void:
	if current_enemy_count < enemies_per_wave_count:
		_spawn_new_enemy(_pick_enemy())
		var spawn_delay := randf_range(spawn_rate / 2, spawn_rate)
		spawn_timer.start(spawn_delay)
	else:
		_end_wave()


func _pick_enemy() -> String:
	var tot_probability: int = 0
	for key in spawn_probabilities.keys():
		tot_probability += spawn_probabilities[key]
	var rand_number = randi_range(0, tot_probability - 1)
	var enemy_name: String
	for key in spawn_probabilities.keys():
		if rand_number < spawn_probabilities[key]:
			enemy_name = key
			break
		rand_number -= spawn_probabilities[key]
	return enemy_name


func _on_enemy_removed():
	_enemy_removed_count += 1
	if _enemy_removed_count == wave_count * enemies_per_wave_count:
		enemies_defeated.emit()
