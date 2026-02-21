extends Node
class_name XPManager

@onready var playerVars:=get_node("/root/PlayerVariables")
var xp_points:int = 0
var current_lvl = 0
var current_xp_cap:int
@export_category("Leveling Details")
@export var xp_caps:Array[int]
@export_category("UI Elements")
@export var xp_label:Label
@export var xp_bar:TextureProgressBar

func _ready() -> void:
	playerVars.connect("get_xp", Callable(self,"_get_xp"))
	_level_up()
	
func _level_up():
	if current_lvl>=xp_caps.size()-1: return
	current_lvl +=1
	current_xp_cap = xp_caps[current_lvl-1]
	xp_label.text = str(current_lvl)
	_set_progress_bar()
	if current_lvl == 1: return
	xp_points -= xp_caps[current_lvl-2]
	 
func _get_xp(points):
	xp_points += points
	xp_bar.value = xp_points
	if xp_points>=current_xp_cap:
		_level_up()
		
func _set_progress_bar():
	xp_bar.min_value = 0
	xp_bar.max_value = current_xp_cap
	xp_bar.value = xp_points
	
	
