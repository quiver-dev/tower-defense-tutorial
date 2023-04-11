extends MoveState

@onready var shooter : Shooter

func enter(state_machine: StateMachine, prev_state: State) -> void:
	super(state_machine, prev_state)
	shooter = enemy.get_node("Shooter")

func update(delta: float) -> void:
	super(delta)
	if shooter and shooter.targets.size() > 0:
		shooter._rotate_shooter(delta)
		self.state_machine.transition_to("Shoot")
