extends GridElement
class_name Pickable

@export_category("Category Icons")
@export var img_dict:Dictionary[PlayerVariables.PickType, Texture2D]
@export var img_texture:TextureRect
var pickData:PickableClass

func _set_item():
	var pickMesh = pickData.mesh.instantiate()
	add_child(pickMesh)
	img_texture.texture = img_dict[pickData.pickType]
	life_label.text = str(pickData.points)

func _on_area_3d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	playerVars.emit_signal("item_picked", pickData.pickType, pickData.points)
	queue_free()
	
