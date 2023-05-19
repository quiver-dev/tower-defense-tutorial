extends State

@onready var enemy := owner as Enemy
@onready var shooter: Shooter = enemy.get_shooter()

func update(delta: float) -> void:
	if shooter:
		if shooter.targets.size() > 0:
			var target_pos: Vector2 = shooter.targets.front().global_position
			var target_rot: float = enemy.global_position.direction_to(target_pos).angle()
			enemy.anim_sprite.rotation = lerp_angle(enemy.anim_sprite.rotation, target_rot, enemy.rot_speed * delta)
			if shooter.should_shoot():
				shooter.shoot()
		else:
			state_machine.transition_to("Move")
