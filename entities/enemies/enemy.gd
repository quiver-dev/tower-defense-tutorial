class_name Enemy
extends CharacterBody2D

signal enemy_died(enemy: Enemy)

@export var speed := 150
@export var rot_speed: float = 10.0
@export var health := 100:
	set = set_health
@export var objective_damage := 10
@export var kill_reward := 100

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var state_machine := $StateMachine as StateMachine

func _ready() -> void:
	nav_agent.max_speed = speed
	
	var objective: Node2D = $/root/Map/Objective
	nav_agent.set_target_position(objective.global_position)
	nav_agent.max_speed = speed
	
func _calculate_rot(start_rot: float, target_rot: float, _speed: float, delta: float) -> float:
	return lerp_angle(start_rot, target_rot, _speed * delta)
	
func _move(delta: float) -> void:
	var next_path_pos: Vector2 = nav_agent.get_next_path_position()
	var cur_agent_pos: Vector2 = global_position
	var new_velocity: Vector2 = cur_agent_pos.direction_to(next_path_pos) * speed	
	if not nav_agent.avoidance_enabled:
		velocity = new_velocity
		move_and_slide()
	else:
		nav_agent.set_velocity(new_velocity)
	$AnimatedSprite2D.global_rotation = _calculate_rot($AnimatedSprite2D.global_rotation,
			velocity.angle(), rot_speed, delta)
	$CollisionShape2D.global_rotation = _calculate_rot($CollisionShape2D.global_rotation,
			velocity.angle(), rot_speed, delta)

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()
	
func set_health(value: int) -> void:
	health = max(0, value)
	if health == 0:
		state_machine.transition_to("Die")
		
func get_shooter() -> Shooter:
	return null
	
func play_animation(anim_name: String) -> void:
	$AnimatedSprite2D.play(anim_name)
		
func die() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	speed = 0
	$AnimatedSprite2D.play("die")
	enemy_died.emit(self)

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "die":
		queue_free()
