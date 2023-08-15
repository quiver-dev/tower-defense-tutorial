class_name Objective
extends Area2D

signal health_changed(health: int)
signal objective_destroyed

@export var health := 500:
	set = set_health
	
@onready var collision_shape := $CollisionShape2D as CollisionShape2D
@onready var anim_sprite := $AnimatedSprite2D as AnimatedSprite2D
	
func set_health(value: int) -> void:
	health = max(0, value)
	health_changed.emit(health)
	if health == 0:
		collision_shape.set_deferred("disabled", true)
		anim_sprite.play("die")
		$Explosion/AnimationPlayer.play("big_explosion")


func _on_body_entered(body: Node2D) -> void:
	if body is Infantry:
		var infantry = body as Infantry
		health -= infantry.objective_damage
		infantry.enemy_removed.emit()
		infantry.queue_free()


func _on_animated_sprite_2d_animation_finished():
	if anim_sprite.animation == "die":
		objective_destroyed.emit()
