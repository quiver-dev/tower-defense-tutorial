class_name Objective
extends Area2D

signal health_changed(health: int)

@export var health := 500:
	set = set_health
	
@onready var collision := $CollisionShape2D as CollisionShape2D
@onready var anim_sprite := $AnimatedSprite2D as AnimatedSprite2D
	
func set_health(value: int) -> void:
	health = max(0, value)
	health_changed.emit(health)
	if health == 0:
		collision.set_deferred("disabled", true)
		anim_sprite.play("die")

func _on_body_entered(body: Node2D) -> void:
	if body is Enemy:
		health -= (body as Enemy).objective_damage
		(body as Enemy).queue_free()
