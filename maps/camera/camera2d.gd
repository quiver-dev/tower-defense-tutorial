extends Camera2D

@export var min_zoom := 0.25
@export var max_zoom := 1.0
@export var zoom_rate := 16.0
@export var zoom_delta := 0.1
@export var drag_speed := 1.0

@onready var target_zoom: float = zoom.x
@onready var hud := $HUD as HUD

func _physics_process(delta: float) -> void:
	zoom.x = lerp(zoom.x, target_zoom, zoom_rate * delta)
	zoom.y = lerp(zoom.y, target_zoom, zoom_rate * delta)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			target_zoom = min(target_zoom + zoom_delta, max_zoom)
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			target_zoom = max(target_zoom - zoom_delta, min_zoom)
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_MIDDLE:
				Input.set_default_cursor_shape(Input.CURSOR_DRAG)
		elif event.button_index == MOUSE_BUTTON_MIDDLE:
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	if event is InputEventMouseMotion and \
			event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
		position -= event.relative * drag_speed / zoom
