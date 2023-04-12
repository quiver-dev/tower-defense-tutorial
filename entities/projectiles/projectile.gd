extends Area2D
class_name Projectile

@onready var sprite := $Sprite2D as Sprite2D
@onready var hit_vfx := $HitVfx as AnimatedSprite2D
@onready var collision_shape := $CollisionShape2D as CollisionShape2D

var speed: int
var damage: int
var velocity: Vector2

func start(_position: Vector2, _rotation: float, _speed: int, _damage: int) -> void:
	global_position = _position
	rotation = _rotation
	speed = _speed
	damage = _damage
	velocity = Vector2.RIGHT.rotated(_rotation) * speed
	
func _physics_process(delta: float) -> void:
	global_position += velocity * delta

func _on_body_entered(body):
	if body is Enemy or body is Tower:
		body.health -= damage
		_explode()
		
func _on_area_entered(area):
	if area is Objective:
		area.health -= damage
		_explode()
		
func _explode() -> void:
	set_physics_process(false)
	collision_shape.set_deferred("disabled", true)
	sprite.hide()
	hit_vfx.show()
	hit_vfx.play("hit")


func _on_hit_vfx_animation_finished():
	queue_free()


func _on_lifetime_timer_timeout():
	queue_free()

