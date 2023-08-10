extends MoveState

@onready var shooter: Shooter

func enter(sm: StateMachine, prev_state: State) -> void:
	super(sm, prev_state)
	shooter = enemy.get_shooter()


func update(delta: float) -> void:
	super(delta)
	if shooter and not shooter.targets.is_empty():
		self.state_machine.transition_to("ShootStationary")
