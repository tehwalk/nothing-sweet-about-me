extends Node3D
class_name Portal

@onready var playerVars = get_node("/root/PlayerVariables")


func _on_area_3d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	playerVars.emit_signal("reached_portal")
