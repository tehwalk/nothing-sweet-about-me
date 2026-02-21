extends Control
class_name GameOverScreen

@onready var player_vars:=get_node("/root/PlayerVariables")
@onready var main_menu_scene:=preload("res://Game Segments/main_menu.tscn")
@onready var state_label:=$Panel/StateLabel

func _ready() -> void:
	visible = false
	player_vars.connect("game_over", Callable(_game_over))
	
func _game_over(won:bool):
	visible = true
	if won: state_label.text = "YOU WON"
	else: state_label.text = "YOU LOST"
	
func _retry():
	get_tree().reload_current_scene()
	
func _go_to_main_menu():
	get_tree().change_scene_to_packed(main_menu_scene)
