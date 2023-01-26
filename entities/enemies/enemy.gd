class_name Enemy
extends CharacterBody2D

@export var speed := 150
@export var health := 100
@export var objective_damage := 10

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _ready() -> void:
	nav_agent.max_speed = speed
	
	var objective: Node2D = $/root/Map/Objective
	nav_agent.set_target_location(objective.global_position)
	
func _physics_process(delta: float) -> void:
	var next_path_pos: Vector2 = nav_agent.get_next_location()
	var cur_agent_pos: Vector2 = global_position
	var new_velocity: Vector2 = cur_agent_pos.direction_to(next_path_pos) * speed
	#nav_agent.set_velocity(new_velocity)
	velocity = new_velocity
	move_and_slide()

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	pass
	#velocity = safe_velocity
	#move_and_slide()
