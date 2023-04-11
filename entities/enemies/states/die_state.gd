class_name DieState
extends State

var enemy := owner as Enemy

func enter(state_machine: StateMachine, prev_state: State) -> void:
	enemy.die()
