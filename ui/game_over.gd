extends Panel

@onready var anim_player := $AnimationPlayer as AnimationPlayer

func enable():
	get_tree().paused = true
	anim_player.play("show")


func _hide():
	get_tree().paused = false
	visible = false


func _on_retry_pressed():
	_hide()
	var e = get_tree().change_scene_to_file("res://maps/map.tscn")
	if e != OK:
		push_error("Error while changing scene: %s" % str(e))


func _on_exit_pressed():
	_hide()
	var e = get_tree().change_scene_to_file("res://ui/main_menu.tscn")
	if e != OK:
		push_error("Error while changing scene: %s" % str(e))
