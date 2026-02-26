extends Node3D
class_name Cell

@onready var cell_mesh:=$MeshInstance3D
@onready var cell_label:=$DebugCoordinates
@onready var playerVars = get_node("/root/PlayerVariables")
@onready var highlight_material:=preload("res://Materials/tile_highlight.tres")
@export var active_material:Material
@export var inactive_material:Material
@export var unreached_material:Material
var can_pass:bool = true
var cell_index:Vector2
var cell_child:GridElement
	
func _set_cell_index(value:Vector2):
	cell_index = value
	cell_label.text = str(cell_index)

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	#print("click")
	if event is InputEventMouseButton && Input.is_action_just_pressed("left_mouse_click"):
		playerVars.emit_signal("changed_pos", self)

func _on_area_3d_area_exited(area):
	can_pass = false
	playerVars.emit_signal("cell_destroyed") ##HACK: Not used, what to do with it?
	#queue_free()
	cell_mesh.material_override = inactive_material
	cell_mesh.material_overlay = null

func _on_area_3d_mouse_entered() -> void:
	if !cell_child: return
	cell_child.ui3d._show_ui()
	cell_child.mesh_cluster._highlight_on()

func _on_area_3d_mouse_exited() -> void:
	if !cell_child: return
	cell_child.ui3d._hide_ui()
	cell_child.mesh_cluster._highlight_off()
	
func _on_child_entered_tree(node: Node) -> void:
	if !node is GridElement: return
	cell_child = node
	
func _highlight():
	cell_mesh.material_override = active_material
	cell_mesh.material_overlay = highlight_material
	
func _no_highlight():
	cell_mesh.material_override = unreached_material
	cell_mesh.material_overlay = null
