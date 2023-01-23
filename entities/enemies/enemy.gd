extends CharacterBody2D

@export var speed: int = 300

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _ready() -> void:
	nav_agent.max_speed = speed
	
	var objective: Node2D = $/Map/Objective
	nav_agent.set_target_location(objective.global_position)
	
