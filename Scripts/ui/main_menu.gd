extends Control
class_name MainMenu

@onready var transition:= get_node("/root/SceneTransition")
@onready var game_scene = load("res://Game Segments/world.tscn")

func _ready() -> void:
	transition._transition_show()

func _play_game():
	#scene_transition._transition_hide()
	await transition._transition_hide()
	get_tree().change_scene_to_packed(game_scene)
