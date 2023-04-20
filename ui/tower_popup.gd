extends CanvasLayer

signal tower_requested(type: String)

func _on_button_pressed(type: String) -> void:
	tower_requested.emit(type)


func _on_close_pressed():
	hide()

