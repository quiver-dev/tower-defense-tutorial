class_name EntityHUD
extends Control


const RED := Color("#e86a17")
const YELLOW := Color("#d2b82d")
const GREEN := Color("#88e060")

@onready var health_bar := $VBoxContainer/HealthBar as TextureProgressBar
@onready var reload_bar := $VBoxContainer/ReloadBar as ProgressBar


func animate_reload_bar(duration: float) -> void:
	reload_bar.value = reload_bar.min_value
	reload_bar.show()
	var tween := create_tween()
	tween.tween_property(reload_bar, "value", reload_bar.max_value, duration)
	tween.tween_callback(reload_bar.hide)


func _on_reload_bar_value_changed(value):
	if value == reload_bar.max_value:
		reload_bar.hide()
	elif value > reload_bar.max_value * 0.66:
		reload_bar.self_modulate = GREEN
	elif value > reload_bar.max_value * 0.33:
		reload_bar.self_modulate = YELLOW
	elif value > reload_bar.max_value * 0.0:
		reload_bar.self_modulate = RED


func _on_health_bar_value_changed(value: int):
	health_bar.self_modulate = RED if value <= health_bar.max_value / 4 else GREEN
