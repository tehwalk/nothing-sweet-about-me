extends PlayerAbility
class_name Smite

func _activate():
	print("smite!")
	game_vars.emit_signal("go_unstop")
