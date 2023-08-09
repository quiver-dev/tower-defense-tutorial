extends State

@onready var enemy := owner as Enemy
@onready var shooter: Shooter = enemy.get_shooter()

func enter(sm: StateMachine, prev_state: State) -> void:
	super.enter(sm, prev_state)
	enemy.play_animation("shoot_stationary")
	
	for i in len(shooter.targets):
		if shooter.targets[i] is Objective:
			var objective = shooter.targets.pop_at(i)
			shooter.targets.push_front(objective)
			break
	
	enemy.nav_agent.set_velocity(Vector2.ZERO)


func update(delta: float) -> void:
	if shooter:
		if shooter.targets.size() > 0:
			shooter._rotate_shooter(delta)
			if shooter.should_shoot():
				shooter.shoot()

