extends Shooter

var _shoot_a := true
	
func shoot() -> void:
	can_shoot = false
	var _muzzle : Marker2D
	if _shoot_a:
		_muzzle = gun.get_children()[0]
		_play_animations("shoot_a")
	else:
		_muzzle = gun.get_children()[1]
		_play_animations("shoot_b")
	_instantiate_projectile(_muzzle.global_position, targets.front())
	firerate_timer.start(fire_rate)
	_shoot_a = !_shoot_a

func _rotate_shooter(_delta: float):
	pass
