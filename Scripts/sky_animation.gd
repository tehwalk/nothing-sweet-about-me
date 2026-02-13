extends WorldEnvironment

@export var duration:float
var anim_tween:Tween

func _ready() -> void:
	anim_tween = create_tween()
	anim_tween.set_loops()
	anim_tween.tween_property(environment,"sky_rotation", Vector3(0,360,0), duration)
