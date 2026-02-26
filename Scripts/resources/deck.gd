extends Resource
class_name Deck

@export var level_tables:Array[SpawnTable]

func _init_deck():
	for i in level_tables.size():
		if i==level_tables.size() - 1:
			level_tables[i].spawn_boss = true
		else: level_tables[i].spawn_boss = false
