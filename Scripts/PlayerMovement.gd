extends Node3D
class_name Player

@onready var playerVars = get_node("/root/PlayerVariables")
var healthPoints:int = 0
var weaponPoints:int = 0
var shieldPoints:int = 0
@export_category("Player Variables")
@export var healthPointsMax:int = 3
@export var shieldPointsMax:int = 1
@export var weaponPointsMax:int = 1
@export var movement_time:float = 0.2
@export_category("UI Variables")
@export var healthText:Label
@export var weaponText:Label
@export var shieldText:Label

# Called when the node enters the scene tree for the first time.
func _ready():
	playerVars.connect("hit_enemy", Callable(self,"_handle_attack"))
	playerVars.connect("item_picked", Callable(self,"pick_item"))
	_set_player_state()
	update_ui()
	#print(str(int(playerVars.PickType.HEALTH)))
	
func _set_player_state():
	healthPoints = healthPointsMax
	shieldPoints = shieldPointsMax
	weaponPoints = weaponPointsMax
	
func _handle_movement(next_pos:Vector3):
	#look_at(next_pos, Vector3.UP, true)
	#position = next_pos
	_handle_rotation(next_pos)
	var tween = create_tween()
	#tween.tween_callback(look_at.bind(Vector3.UP, next_pos, true))
	tween.tween_property(self, "global_position", next_pos, movement_time).set_ease(Tween.EASE_IN_OUT)
	return tween.finished
	
func _handle_rotation(next_pos:Vector3):
	var dist = next_pos - position
	#look_at(dist)
	rotation.y = atan2(dist.x,dist.z)

##FIXME: Subtract from other values when the first one has been depleted and there's more points to subtract (e.g. remove the last point of shield and 1 point from health for 2 damage
func _handle_attack(attackPoints):
	if weaponPoints > 0:
		#print("ez pz")
		weaponPoints -= attackPoints
		if weaponPoints<0:weaponPoints=0
	elif shieldPoints >0:
		shieldPoints -= attackPoints
		if shieldPoints<0:shieldPoints=0
	else: 
		healthPoints -= attackPoints
		if healthPoints<= 0:
			print("fuck")
			playerVars.emit_signal("game_over", false)
	update_ui()
	#pass
	
func pick_item(itemType, itemPoints):
	#print("Type:" + str(itemType))
	match itemType:
		PlayerVariables.PickType.HEALTH:
			healthPoints += itemPoints
		PlayerVariables.PickType.WEAPON:
			weaponPoints += itemPoints
		PlayerVariables.PickType.SHIELD:
			shieldPoints += itemPoints
	update_ui()
	
			
func update_ui():
	healthText.text = "HEALTH: " + str(healthPoints)
	weaponText.text = "WEAPON: " + str(weaponPoints)
	shieldText.text = "SHIELD: " + str(shieldPoints)
	
func _go_to_portal():
	var portal_tween = create_tween()
	portal_tween.tween_property(self, "scale", Vector3(0.1,0.1,0.1), movement_time)
	return portal_tween.finished
	
func _reset_scale():
	scale = Vector3.ONE
