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
@export var upward_distance:float
@export_category("UI Variables")
@export var healthText:Label
@export var weaponText:Label
@export var shieldText:Label

# Called when the node enters the scene tree for the first time.
func _ready():
	playerVars.connect("hit_enemy", Callable(self,"_handle_damage"))
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
	var middle_pos = lerp(global_position, next_pos, 0.5) + Vector3(0,upward_distance,0)
	#tween.tween_callback(look_at.bind(Vector3.UP, next_pos, true))
	tween.tween_property(self, "global_position", middle_pos, movement_time/2).set_ease(Tween.EASE_OUT_IN)
	tween.tween_property(self, "global_position", next_pos, movement_time/2).set_ease(Tween.EASE_IN_OUT)
	return tween.finished
	
func _handle_rotation(next_pos:Vector3):
	var dist = next_pos - global_position
	#look_at(dist)
	global_rotation.y = atan2(dist.x,dist.z)
	
func _handle_damage(dmg:int, is_boss=false):
	var weapon_diff = weaponPoints - dmg
	#it just affects weapon
	if weapon_diff>=0:
		weaponPoints = weapon_diff
		update_ui()
		_check_for_boss(is_boss)
		return
	weaponPoints = 0
	#a subtraction from shield, as weapon_diff is a negative number
	var shield_diff = shieldPoints + weapon_diff
	if shield_diff>=0:
		shieldPoints = shield_diff
		update_ui()
		_check_for_boss(is_boss)
		return
	shieldPoints = 0 
	#a subtraction from health, as shield_diff is a negative number
	var health_diff = healthPoints + shield_diff
	if health_diff>0:
		healthPoints = health_diff
		update_ui()
		_check_for_boss(is_boss)
		return
	print("fuck")
	playerVars.emit_signal("game_over", false)
	
func _handle_victory(is_boss:bool, xp:int = 0):
	update_ui()
	_check_for_boss(is_boss)
	
func _check_for_boss(is_boss:bool):
	if !is_boss: return
	print("You won")
	playerVars.emit_signal("game_over", true)
	
func pick_item(itemType, itemPoints):
	#print("Type:" + str(itemType))
	match itemType:
		PlayerVariables.PickType.HEALTH:
			if healthPoints>=healthPointsMax: 
				return
			healthPoints += itemPoints
			if healthPoints>healthPointsMax: 
				healthPoints = healthPointsMax
		PlayerVariables.PickType.WEAPON:
			weaponPoints += itemPoints
		PlayerVariables.PickType.SHIELD:
			shieldPoints += itemPoints
	update_ui()
	
			
func update_ui():
	healthText.text = str(healthPoints)
	weaponText.text = str(weaponPoints)
	shieldText.text = str(shieldPoints)
	
func _go_to_portal():
	var portal_tween = create_tween()
	portal_tween.tween_property(self, "scale", Vector3(0.1,0.1,0.1), movement_time).set_trans(Tween.TRANS_SPRING)
	return portal_tween.finished
	
func _reset_scale():
	scale = Vector3.ONE
