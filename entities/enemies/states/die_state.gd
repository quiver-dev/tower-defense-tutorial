class_name DieState
extends State

@onready var enemy := owner as Enemy

func enter(state_machine: StateMachine, prev_state: State) -> void:
	super.enter(state_machine, prev_state)
	enemy.die()
