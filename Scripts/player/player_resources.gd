extends Node
class_name PlayerResources

@onready var playerVars = get_node("/root/PlayerVariables")
var healthPoints:int = 0
var weaponPoints:int = 0
var shieldPoints:int = 0
@export_category("Player Variables")
@export var healthPointsMax:int = 3
@export var shieldPointsMax:int = 1
@export var weaponPointsMax:int = 1
@export_category("UI Variables")
@export var health_bar:Range
@export var healthText:Label
@export var weaponText:Label
@export var shieldText:Label
var untouchable:bool = false

func _ready() -> void:
	playerVars.connect("hit_enemy", Callable(self,"_handle_damage"))
	playerVars.connect("item_picked", Callable(self,"pick_item"))
	_set_player_state()
	health_bar.min_value = 0
	health_bar.max_value = healthPointsMax
	update_ui()
	
func _set_player_state():
	healthPoints = healthPointsMax
	shieldPoints = shieldPointsMax
	weaponPoints = weaponPointsMax
	
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
			weaponPoints = itemPoints
		PlayerVariables.PickType.SHIELD:
			shieldPoints = itemPoints
	update_ui()
	
func update_ui():
	health_bar.value = healthPoints
	healthText.text = str(healthPoints) + " / " + str(healthPointsMax)
	weaponText.text = str(weaponPoints)
	shieldText.text = str(shieldPoints)
	
func _handle_victory(action:Callable):
	update_ui()
	action.call()
	
#region Damage Functions
func _handle_damage(dmg:int, victory_callable:Callable, enemy_type:EnemyClass.EnemyType):
	if untouchable:
		victory_callable.call()
		return
	match enemy_type:
		EnemyClass.EnemyType.Normal:
			_handle_damage_normal(dmg, victory_callable)
		EnemyClass.EnemyType.Spectral:
			_handle_damage_ignore_sword(dmg, victory_callable)
		EnemyClass.EnemyType.Vamp:
			_handle_damage_ignore_shield(dmg, victory_callable)
		EnemyClass.EnemyType.Hellish:
			_handle_damage_health_only(dmg, victory_callable)

func _handle_damage_normal(dmg:int, victory_callable:Callable):
	var weapon_diff = weaponPoints - dmg
	#it just affects weapon
	if weapon_diff>=0:
		weaponPoints = weapon_diff
		_handle_victory(victory_callable)
		return
	weaponPoints = 0
	#a subtraction from shield, as weapon_diff is a negative number
	var shield_diff = shieldPoints + weapon_diff
	if shield_diff>=0:
		shieldPoints = shield_diff
		_handle_victory(victory_callable)
		return
	shieldPoints = 0 
	#a subtraction from health, as shield_diff is a negative number
	var health_diff = healthPoints + shield_diff
	if health_diff>0:
		healthPoints = health_diff
		_handle_victory(victory_callable)
		return
	#print("fuck")
	playerVars.emit_signal("game_over", false)
	
func _handle_damage_ignore_sword(dmg:int, victory_callable:Callable):
	var shield_diff = shieldPoints - dmg
	if shield_diff>=0:
		shieldPoints = shield_diff
		_handle_victory(victory_callable)
		return
	shieldPoints = 0 
	#a subtraction from health, as shield_diff is a negative number
	var health_diff = healthPoints + shield_diff
	if health_diff>0:
		healthPoints = health_diff
		_handle_victory(victory_callable)
		return
	#print("fuck")
	playerVars.emit_signal("game_over", false)
	
func _handle_damage_ignore_shield(dmg:int, victory_callable:Callable):
	var weapon_diff = weaponPoints - dmg
	#it just affects weapon
	if weapon_diff>=0:
		weaponPoints = weapon_diff
		_handle_victory(victory_callable)
		return
	weaponPoints = 0
	#a subtraction from health, as weapon_diff is a negative number
	var health_diff = healthPoints + weapon_diff
	if health_diff>0:
		healthPoints = health_diff
		_handle_victory(victory_callable)
		return
	#print("fuck")
	playerVars.emit_signal("game_over", false)
	
func _handle_damage_health_only(dmg:int, victory_callable:Callable):
	var health_diff = healthPoints - dmg
	if health_diff>0:
		healthPoints = health_diff
		_handle_victory(victory_callable)
		return
	playerVars.emit_signal("game_over", false)
#endregion
