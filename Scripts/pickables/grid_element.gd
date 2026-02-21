extends Node3D
class_name GridElement

@onready var playerVars = get_node("/root/PlayerVariables")
@export var ui: Sprite3D
@export var life_label:Label
@export var tween_time:float=0.1

func _ready() -> void:
	_hide_ui()

func _show_ui():
	ui.visible = true
	var tween = create_tween()
	tween.tween_property(ui,"scale", Vector3.ONE, tween_time).from(Vector3(0.1,0.1,0.1)).set_trans(Tween.TRANS_BOUNCE)
	
func _hide_ui():
	var tween = create_tween()
	tween.tween_property(ui,"scale", Vector3(0.1,0.1,0.1), tween_time).from(Vector3.ONE)
	await tween.finished
	ui.visible = false
	
