extends Projectile


@export var steer_force := 4000.0

var _acceleration: Vector2

func _physics_process(delta: float) -> void:
	if is_instance_valid(target):
		_acceleration += _steer()
		velocity += _acceleration * delta
		#velocity = velocity.limit_length(speed)
		rotation = velocity.angle()
	global_position += velocity * delta


func _steer() -> Vector2:
	# calculate the desired direction vector at maximum speed
	var desired := global_position.direction_to(target.global_position) * speed
	# return the amount we can turn towards the desired direction
	return velocity.direction_to(desired) * steer_force
