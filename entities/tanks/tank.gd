class_name Tank
extends Enemy

@onready var shooter = $Shooter as Shooter

func die() -> void:
	super.die()
	shooter.die()
