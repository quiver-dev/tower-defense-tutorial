extends Shooter

var _shoot_a := true
	
func shoot() -> void:
	can_shoot = false
	var muzzle: Marker2D
	if _shoot_a:
		muzzle = gun.get_child(0)
		_play_animations("shoot_a")
	else:
		muzzle = gun.get_child(1)
		_play_animations("shoot_b")
	muzzle_flash.global_position = muzzle.global_position
	shoot_sound.play()
	_instantiate_projectile(muzzle.global_position, targets.front())
	firerate_timer.start(fire_rate)
	has_shot.emit(firerate_timer.wait_time)
	_shoot_a = !_shoot_a
