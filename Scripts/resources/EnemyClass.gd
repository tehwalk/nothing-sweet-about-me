extends Resource
class_name EnemyClass

#TODO: Add more diverse stuff
enum EnemyType {Normal, Spectral, Vamp, Hellish}

@export var enemy_name:String
@export var enemy_type:EnemyType
@export var hit_points:int = 1
@export var xp_points:int
@export var mesh:PackedScene
