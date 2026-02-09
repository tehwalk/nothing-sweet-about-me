extends Resource
class_name SpawnTable

@export var enemy_table:Dictionary[EnemyClass, int]
@export var pickable_table:Dictionary[PickableClass, int]
@export var spawn_boss:bool
@export var spawn_merchant:bool
