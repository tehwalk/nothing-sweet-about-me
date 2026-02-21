extends Control

var transition_time:float = 1.0

func _ready() -> void:
	visible = false

func _transition_hide():
	visible = true
	var tween = create_tween()
	tween.tween_method(_set_shader_factor, 0.0, 1.0, transition_time)
	return tween.finished
	
func _transition_show():
	visible = true
	var tween = create_tween()
	tween.tween_method(_set_shader_factor, 1.0, 0.0, transition_time)
	tween.tween_callback(func(): visible = false)
	return tween.finished
	
func _set_shader_factor(value:float):
	material.set_shader_parameter("factor", value)
	
