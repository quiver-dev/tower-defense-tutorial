class_name ShootState
extends State

@onready var enemy := owner as Enemy
@onready var shooter : Shooter = enemy.get_shooter()

func enter(state_machine: StateMachine, prev_state: State) -> void:
	super.enter(state_machine, prev_state)
	enemy.play_animation("shoot")

func update(delta: float) -> void:
	enemy._move(delta)
	if shooter:
		if shooter.targets.size() > 0:
			shooter._rotate_shooter(delta)
		else:
			state_machine.transition_to("Move")
		if shooter.should_shoot(delta):
			shooter.shoot()
