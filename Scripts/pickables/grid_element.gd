extends Node3D
class_name GridElement

@onready var playerVars = get_node("/root/PlayerVariables")
@export var ui3d:Ui3D
var mesh_cluster:MeshCluster

func _ready() -> void:
	ui3d._hide_ui()
		
