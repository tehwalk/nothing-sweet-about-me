extends Node
class_name Boss

@onready var playerVars = get_node("/root/PlayerVariables")
@onready var label:Label3D=$Label
@export var hit_points:int

func _ready() -> void:
	label.text = str(hit_points)
	
func _on_area_3d_area_entered(area: Area3D) -> void:
	playerVars.emit_signal("hit_enemy", hit_points, 
		func(): playerVars.emit_signal("game_over", true))
