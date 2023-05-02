extends StaticBody2D
class_name Tower

signal tower_destroyed

@export_range(1, 1000) var health: int = 100:
	set = set_health
@export var tower_type: String

var max_health: int

@onready var collision = $CollisionShape2D as CollisionShape2D
@onready var shooter = $Shooter as Shooter

func _ready():
	max_health = health

func _physics_process(delta: float) -> void:
	if shooter.targets:
		shooter._rotate_shooter(delta)
		if shooter.should_shoot():
			shooter.shoot()
	
func set_health(value: int) -> void:
	health = max(0, value)
	if health == 0:
		set_physics_process(false)
		collision.set_deferred("disabled", true)
		shooter.die()
		tower_destroyed.emit()
	
func repair():
	health = max_health

func _on_gun_animation_finished():
	if shooter.gun.animation == "die":
		queue_free()
