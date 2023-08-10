class_name Helicopter
extends Enemy

@onready var shooter := $Shooter as Shooter
@onready var rotor := $Rotor as AnimatedSprite2D
@onready var shadow := $Shadow as AnimatedSprite2D

func get_shooter() -> Shooter:
	return shooter


func die() -> void:
	super.die()
	shooter.die()
	$Explosion/AnimationPlayer.play("default_explosion")


func _process(_delta: float) -> void:
	shooter.global_rotation = anim_sprite.global_rotation	
	rotor.global_rotation = anim_sprite.global_rotation
	shadow.global_rotation = anim_sprite.global_rotation
