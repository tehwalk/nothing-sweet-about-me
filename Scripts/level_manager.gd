extends Node
class_name LevelManager

##TODO: Add more stuff (enemies and pickables)
@export var level_spawn_tables:Array[SpawnTable]
@export var lvl_label:Label
var current_table:SpawnTable
var lvl:int = 0

func _ready() -> void:
	_set_level()
	
func _level_up():
	lvl+=1
	_set_level()
	
func _set_level():
	lvl_label.text = "LEVEL: " + str(lvl)
	if lvl >= level_spawn_tables.size(): return
	current_table = level_spawn_tables[lvl]
	
##Returns a random enemy type of the active spawn table, based on the weighted possibilities of the table
func _get_enemy_data() -> EnemyClass:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var weighted_sum = 0
	for e in current_table.enemy_table:
		weighted_sum += current_table.enemy_table[e]
	var selected = rng.randi_range(0, weighted_sum)
	for e in current_table.enemy_table:
		if selected <= current_table.enemy_table[e]:
			return e
		selected -= current_table.enemy_table[e]
	return null
	
##Returns a random pickable type of the active spawn table, based on the weighted possibilities of the table
func _get_pickable_data() -> PickableClass:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var weighted_sum = 0
	for e in current_table.pickable_table:
		weighted_sum += current_table.pickable_table[e]
	var selected = rng.randi_range(0, weighted_sum)
	for e in current_table.pickable_table:
		if selected <= current_table.pickable_table[e]:
			return e
		selected -= current_table.pickable_table[e]
	return null

#func _pick_zombie_type()->ZombieType:
	#var rng = RandomNumberGenerator.new()
	#rng.randomize()
	#var weighted_sum = 0
	#for z in zombie_spawn_table.table:
		#weighted_sum += zombie_spawn_table.table[z]
	#var selected = rng.randi_range(0, weighted_sum)
	#for z in zombie_spawn_table.table:
		#if selected <= zombie_spawn_table.table[z]:
			#return z
		#selected -= zombie_spawn_table.table[z]
	#return null
