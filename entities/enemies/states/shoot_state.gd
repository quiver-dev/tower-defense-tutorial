class_name ShootState
extends State

@onready var enemy := owner as Enemy
@onready var shooter: Shooter = enemy.get_shooter()

func enter(sm: StateMachine, prev_state: State) -> void:
	super.enter(sm, prev_state)
	enemy.play_animation("shoot")


func update(delta: float) -> void:
	enemy._move(delta)
	if shooter:
		if shooter.targets.size() > 0:
			shooter._rotate_shooter(delta)
			if shooter.is_objective_in_range():
				self.state_machine.transition_to("ShootStationary")
			elif shooter.should_shoot():
				shooter.shoot()
		else:
			state_machine.transition_to("Move")
