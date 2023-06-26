extends Node2D
class_name Shooter

signal has_shot(reload_time: float)

@export var fire_rate := 0.1
@export var rot_speed := 5.0
@export var projectile_type: PackedScene
@export var projectile_speed := 1000
@export var projectile_damage := 3
@export var projectile_spread := 0.0

var targets: Array[Node2D]
var can_shoot := true
var map: Node

@onready var gun := $Gun as AnimatedSprite2D
@onready var muzzle_flash := $MuzzleFlash as AnimatedSprite2D
@onready var shoot_sound := $ShootSound as AudioStreamPlayer2D
@onready var lookahead := $LookAhead as RayCast2D
@onready var firerate_timer := $FireRateTimer as Timer

func _ready():
	map = find_parent("Map")


func _on_detector_body_entered(body: Node2D) -> void:
	if body not in targets:
		targets.append(body)


func _on_detector_body_exited(body: Node2D) -> void:
	if body in targets:
		targets.erase(body)


func _on_detector_area_entered(area):
	if area not in targets:
		targets.append(area)


func _on_detector_area_exited(area):
	if area in targets:
		targets.erase(area)


func _play_animations(anim_name: String) -> void:
	gun.frame = 0
	muzzle_flash.frame = 0
	gun.play(anim_name)
	muzzle_flash.play(anim_name)


func _rotate_shooter(delta: float):
	if not targets.is_empty():
		var target_pos: Vector2 = targets.front().global_position
		var target_rot: float = global_position.direction_to(target_pos).angle()
		rotation = lerp_angle(rotation, target_rot, rot_speed * delta)


func should_shoot() -> bool:
	return can_shoot and lookahead.is_colliding()


func _instantiate_projectile(_position: Vector2, target: Node2D) -> void:
	var projectile: Projectile = projectile_type.instantiate()
	if map:
		map.add_child(projectile)
	else:
		owner.add_child(projectile)
	projectile.start(_position, rotation + randf_range(-projectile_spread, projectile_spread), projectile_speed, projectile_damage, target)
	projectile.collision_mask = $Detector.collision_mask


func shoot() -> void:
	can_shoot = false
	for _muzzle in gun.get_children():
		_instantiate_projectile(_muzzle.global_position, targets.front())
	_play_animations("shoot")
	shoot_sound.play()
	firerate_timer.start(fire_rate)
	has_shot.emit(firerate_timer.wait_time)


func die():
	set_physics_process(false)
	can_shoot = false
	firerate_timer.stop()
	muzzle_flash.hide()
	gun.play("die")


func is_objective_in_range() -> bool:
	for target in targets:
		if target is Objective:
			return true
	return false


func _on_fire_rate_timer_timeout():
	can_shoot = true


func _on_gun_animation_finished():
	if gun.animation.contains("shoot"):
		_play_animations("idle")
