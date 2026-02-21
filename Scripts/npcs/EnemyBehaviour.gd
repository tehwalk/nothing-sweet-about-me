extends GridElement
class_name Enemy

var enemyData:EnemyClass

func _set_enemy():
	var enemyMesh = enemyData.mesh.instantiate()
	add_child(enemyMesh)
	life_label.text = str(enemyData.hit_points)
	
func _on_area_3d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	playerVars.emit_signal("hit_enemy", enemyData.hit_points, 
			func(): playerVars.emit_signal("get_xp", enemyData.xp_points))
	queue_free()
	
