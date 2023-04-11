class_name State
extends Node

var state_machine : StateMachine

func enter(state_machine: StateMachine, prev_state: State) -> void:
	self.state_machine = state_machine

func exit() -> void:
	return

func update(_delta: float) -> void:
	return
