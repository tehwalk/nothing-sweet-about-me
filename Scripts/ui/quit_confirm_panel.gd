extends Control
class_name ConfirmationPanel

@onready var player_vars:=get_node("/root/PlayerVariables")

func _ready() -> void:
	visible = false
	player_vars.connect("confirm_quit", Callable(self, "_confirm_quit"))
	
func _confirm_quit():
	visible = true
	
func _accept_quit():
	get_tree().change_scene_to_file("res://Game Segments/world.tscn")
	
func _cancel_quit():
	visible = false
	player_vars.emit_signal("cancel_quit")
