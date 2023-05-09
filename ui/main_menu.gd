extends Control

@onready var menu_panel := $Panel as Panel
@onready var how_to_play := $HowToPlay as Panel

func _on_start_pressed():
	var e = get_tree().change_scene_to_file("res://maps/map.tscn")
	if e != OK:
		push_error("Error while changing scene: %s" % str(e))


func _on_quit_pressed():
	get_tree().quit()


func _on_how_to_play_pressed():
	how_to_play.show()
	menu_panel.hide()


func _on_back_pressed():
	how_to_play.hide()
	menu_panel.show()
