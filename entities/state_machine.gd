class_name StateMachine
extends Node

@export var start_state: State

var current_state: State = null

func _ready() -> void:
	await owner.ready
	self.transition_to(start_state.name)


func transition_to(new_state_name: String):
	if has_node(new_state_name):
		var prev_state: State = current_state
		if current_state:
			current_state.exit()
		current_state = get_node(new_state_name)
		current_state.enter(self, prev_state)
	else:
		printerr("%s state not found" % new_state_name)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
