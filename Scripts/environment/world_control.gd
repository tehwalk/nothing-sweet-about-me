extends Node3D
class_name WorldControl

@onready var transition:=get_node("/root/SceneTransition")
@export var rotation_factor:float
@export var rotation_max:float

func _ready() -> void:
	transition._transition_show()

func _input(event):
	if Input.is_action_pressed("right_mouse_click") && event is InputEventMouseMotion:
		var _rotation = rad_to_deg(event.velocity.x * rotation_factor)
		#if rotation > rotation_max: rotation = rotation_max
		_rotation = clampf(_rotation,-rotation_max,rotation_max)
		rotate_y(deg_to_rad(_rotation))
		#print(event.velocity.x)
