class_name MoveState
extends State

@onready var enemy := owner as Enemy

func enter(state_machine: StateMachine, prev_state: State) -> void:
	super(state_machine, prev_state)
	enemy.play_animation("move")
	
func update(delta: float) -> void:
	enemy._move(delta)
