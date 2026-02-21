extends Control

var effect_tween:Tween
@export var tween_time:float = 0.2


func  _ready() -> void:
	pivot_offset_ratio = Vector2(0.5,0.5)
	mouse_entered.connect(_show_effect)
	mouse_exited.connect(_show_effect_reverse)
	
func _show_effect():
	effect_tween = create_tween()
	effect_tween.tween_property(self, "scale", Vector2(1.2,1.2), tween_time)
	
func _show_effect_reverse():
	effect_tween = create_tween()
	effect_tween.tween_property(self, "scale", Vector2(1,1), tween_time).from_current()
