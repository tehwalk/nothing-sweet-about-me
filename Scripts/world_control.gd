extends Node3D
class_name WorldControl

@export var rotation_factor:float
@export var rotation_max:float


func _input(event):
	if Input.is_action_pressed("right_mouse_click") && event is InputEventMouseMotion:
		var _rotation = rad_to_deg(event.velocity.x * rotation_factor)
		#if rotation > rotation_max: rotation = rotation_max
		_rotation = clampf(_rotation,-rotation_max,rotation_max)
		rotate_y(deg_to_rad(_rotation))
		#print(event.velocity.x)
