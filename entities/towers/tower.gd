extends StaticBody2D
class_name Tower

signal tower_destroyed

@export_range(1, 1000) var health := 100:
	set = set_health
@export var tower_type: String
@export var detector_color := Color(0, 0, 1.0, 0.1)

var max_health: int
var _is_mouse_hovering := false

@onready var collision := $CollisionShape2D as CollisionShape2D
@onready var shooter := $Shooter as Shooter
@onready var detector_shape := $Shooter/Detector/CollisionShape2D as CollisionShape2D
@onready var hud := $UI/EntityHUD as EntityHUD

func _ready():
	max_health = health
	hud.health_bar.max_value = max_health
	hud.health_bar.value = health


func _physics_process(delta: float) -> void:
	if shooter.targets:
		shooter._rotate_shooter(delta)
		if shooter.should_shoot():
			shooter.shoot()


func _draw() -> void:
	if _is_mouse_hovering:
		draw_circle(Vector2.ZERO, detector_shape.shape.radius, detector_color)


func set_health(value: int) -> void:
	health = max(0, value)
	if is_instance_valid(hud):
		hud.health_bar.value = health
	if health == 0:
		set_physics_process(false)
		collision.set_deferred("disabled", true)
		shooter.die()
		$Explosion/AnimationPlayer.play("default_explosion")
		tower_destroyed.emit()


func repair():
	health = max_health


func _on_gun_animation_finished():
	if shooter.gun.animation == "die":
		queue_free()


func _on_mouse_entered():
	_is_mouse_hovering = true
	queue_redraw()


func _on_mouse_exited():
	_is_mouse_hovering = false
	queue_redraw()


func _on_shooter_has_shot(reload_time):
	hud.animate_reload_bar(reload_time)
