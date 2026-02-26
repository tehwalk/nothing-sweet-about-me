@abstract
extends Node
class_name PlayerAbility

@onready var game_vars:=get_node("/root/PlayerVariables")
@export var ability_name:String
@export_multiline() var description:String
@export var texture:Texture2D
@export var steps_cap:int
@export var uses_cap:int
var step_count:int = 0
var uses_count:int = 0
var is_ready = false

func _count():
	step_count += 1
	if step_count>=steps_cap:
		is_ready = true
		step_count = 0

func _cast_ability():
	if !is_ready: return
	_activate()
	
@abstract func _activate()
