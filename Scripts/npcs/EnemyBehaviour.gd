extends GridElement
class_name Enemy

@export var enemy_texture:Texture2D
var enemyData:EnemyClass

func _set_enemy():
	var enemyMesh:MeshCluster = enemyData.mesh.instantiate() as MeshCluster
	mesh_cluster = enemyMesh
	add_child(enemyMesh)
	#life_label.text = str(enemyData.hit_points)
	ui3d._set_ui(EnemyClass.EnemyType.keys()[enemyData.enemy_type], str(enemyData.hit_points), null, enemyData.enemy_name)
	
func _on_area_3d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	playerVars.emit_signal("hit_enemy", enemyData.hit_points, 
			func(): playerVars.emit_signal("get_xp", enemyData.xp_points), 
			enemyData.enemy_type)
	queue_free()
	
