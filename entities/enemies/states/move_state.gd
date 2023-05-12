class_name MoveState
extends State

@onready var enemy := owner as Enemy

func enter(sm: StateMachine, prev_state: State) -> void:
	super(sm, prev_state)
	enemy.play_animation("move")


func update(delta: float) -> void:
	enemy._move(delta)
