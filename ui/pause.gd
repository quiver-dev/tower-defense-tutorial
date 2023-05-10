extends Panel

@onready var anim_player := $AnimationPlayer as AnimationPlayer

func _toggle_pause():
	var is_paused = get_tree().paused
	var should_pause = !is_paused
	get_tree().paused = should_pause
	if should_pause:
		visible = should_pause
		anim_player.play("show")
	else:
		anim_player.play_backwards("show")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_toggle_pause()
		

func _on_resume_pressed():
	_toggle_pause()


func _on_restart_pressed():
	_toggle_pause()
	var e = get_tree().change_scene_to_file("res://maps/map.tscn")
	if e != OK:
		push_error("Error while changing scene: %s" % str(e))


func _on_exit_pressed():
	_toggle_pause()
	var e = get_tree().change_scene_to_file("res://ui/main_menu.tscn")
	if e != OK:
		push_error("Error while changing scene: %s" % str(e))
