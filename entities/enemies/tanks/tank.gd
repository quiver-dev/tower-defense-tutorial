class_name Tank
extends Enemy

@onready var shooter = $Shooter as Shooter

func get_shooter() -> Shooter:
	return $Shooter

func die() -> void:
	super.die()
	shooter.die()
	$Explosion.get_node("AnimationPlayer").play("default_explosion")
