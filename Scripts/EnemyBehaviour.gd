extends Node3D
class_name Enemy

@onready var playerVars = get_node("/root/PlayerVariables")
@onready var label:=$Label3D
var enemyData:EnemyClass

func _set_enemy():
	#enemyMesh = get_node("MeshInstance3D") as MeshInstance3D
	#enemyMesh.mesh = enemyData.mesh
	var enemyMesh = enemyData.mesh.instantiate()
	add_child(enemyMesh)
	label.text = "Life: " + str(enemyData.hit_points)
	
func _on_area_3d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	playerVars.emit_signal("hit_enemy", enemyData.hit_points)
	queue_free()
