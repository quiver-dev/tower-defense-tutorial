extends Area2D

@onready var tower_popup := $UI/TowerPopup as CanvasLayer

var _towers_to_build := {
	"gatling": preload("res://entities/towers/gatling_tower.tscn"),
	"cannon": preload("res://entities/towers/cannon_tower.tscn"),
	"missile": preload("res://entities/towers/missile_tower.tscn")
}
var tower : Tower
var map : Map

const PRICE_LABEL_PATH := "UI/TowerPopup/Background/Panel/Towers/%s/Label"

func _ready():
	map = find_parent("Map")

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and \
		event.button_index == MOUSE_BUTTON_LEFT and not tower:
		tower_popup.show()


func _on_tower_popup_tower_requested(type: String):
	if map and map.tower_costs[type] <= map.money:
		tower = _towers_to_build[type].instantiate()
		add_child(tower, true)
		tower_popup.hide()
		tower.tower_destroyed.connect(_on_tower_destroyed)
		map.money -= map.tower_costs[type]
	else:
		var tween := create_tween().set_trans(Tween.TRANS_BACK).\
				set_ease(Tween.EASE_IN_OUT)
		var price_label := get_node(PRICE_LABEL_PATH % [type.capitalize()]) as Label
		price_label.modulate = Color("ff383f")
		tween.tween_property(price_label, "modulate", Color("fff"), 0.25)

func _on_tower_destroyed():
	tower = null
