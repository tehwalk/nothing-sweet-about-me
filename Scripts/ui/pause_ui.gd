extends Control
class_name PauseUI

@onready var player_vars:=get_node("/root/PlayerVariables")
@onready var main_menu_scene:= preload("res://Game Segments/main_menu.tscn")
@export var main_panel:Control
@export var confirm_quit_panel:Control

func _ready() -> void:
	visible = false
	main_panel.visible = true
	confirm_quit_panel.visible = false
	
func _pause() -> void:
	visible = true
	
func _unpause() -> void:
	visible = false
	
func _quit_to_main_menu():
	main_panel.visible = false
	confirm_quit_panel.visible = true
	
func _cancel_quit():
	main_panel.visible = true
	confirm_quit_panel.visible = false
	
func _confirm_quit():
	get_tree().change_scene_to_packed(main_menu_scene)
