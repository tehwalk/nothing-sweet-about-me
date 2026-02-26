extends Node
class_name PlayerAttributes

@onready var playerVars:=get_node("/root/PlayerVariables")

##put player class here!!
var player_abilities:Array
var player_attributes:Array

func _ready() -> void:
	playerVars.connect("step_made", Callable(self, "_abilities_count"))

func _abilities_count():
	pass
	##each ability counts the step inside it
