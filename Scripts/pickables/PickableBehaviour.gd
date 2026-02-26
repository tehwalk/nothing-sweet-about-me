extends GridElement
class_name Pickable

@export_category("Category Icons")
@export var img_dict:Dictionary[PlayerVariables.PickType, Texture2D]
var pickData:PickableClass

func _set_item():
	var pickMesh:MeshCluster = pickData.mesh.instantiate() as MeshCluster
	mesh_cluster = pickMesh
	add_child(pickMesh)
	ui3d._set_ui(PlayerVariables.PickType.keys()[pickData.pickType], str(pickData.points), img_dict[pickData.pickType])

func _on_area_3d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	playerVars.emit_signal("item_picked", pickData.pickType, pickData.points)
	queue_free()
	
