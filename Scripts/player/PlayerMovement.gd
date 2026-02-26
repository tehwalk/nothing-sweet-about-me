extends Node3D
class_name Player

@onready var playerVars = get_node("/root/PlayerVariables")
@export_category("Player Variables")
@export var movement_time:float = 0.2
@export var upward_distance:float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
		
func _handle_movement(next_pos:Vector3):
	#look_at(next_pos, Vector3.UP, true)
	#position = next_pos
	_handle_rotation(next_pos)
	var tween = create_tween()
	var middle_pos = lerp(global_position, next_pos, 0.5) + Vector3(0,upward_distance,0)
	#tween.tween_callback(look_at.bind(Vector3.UP, next_pos, true))
	tween.tween_property(self, "global_position", middle_pos, movement_time/2).set_ease(Tween.EASE_OUT_IN)
	tween.tween_property(self, "global_position", next_pos, movement_time/2).set_ease(Tween.EASE_IN_OUT)
	return tween.finished
	
func _handle_rotation(next_pos:Vector3):
	var dist = next_pos - global_position
	#look_at(dist)
	global_rotation.y = atan2(dist.x,dist.z)
	
func _go_to_portal():
	var portal_tween = create_tween()
	portal_tween.tween_property(self, "scale", Vector3(0.1,0.1,0.1), movement_time).set_trans(Tween.TRANS_SPRING)
	return portal_tween.finished
	
func _reset_scale():
	var reset_tween = create_tween()
	reset_tween.tween_property(self, "scale", Vector3.ONE, movement_time).from(Vector3.ONE * 0.1).set_trans(Tween.TRANS_SPRING)
	#scale = Vector3.ONE
	
