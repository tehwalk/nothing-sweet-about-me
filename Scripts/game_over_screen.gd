extends Control
class_name GameOverScreen

@onready var player_vars:=get_node("/root/PlayerVariables")

func _ready() -> void:
	visible = false
	player_vars.connect("game_over", Callable(_game_over))
	
func _game_over(won:bool):
	visible = true
	
	
func _retry():
	get_tree().reload_current_scene()
