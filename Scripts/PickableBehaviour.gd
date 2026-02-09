extends Node3D
class_name Pickable

@onready var playerVars = get_node("/root/PlayerVariables")
@onready var label:=$Label3D
var pickData:PickableClass
	
func _set_item():
	var pickMesh = pickData.mesh.instantiate()
	add_child(pickMesh)
	label.text = PlayerVariables.PickType.find_key(pickData.pickType) + " " + str(pickData.points)

func _on_area_3d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	playerVars.emit_signal("item_picked", pickData.pickType, pickData.points)
	queue_free()
