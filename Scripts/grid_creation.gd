extends Node3D
class_name GridCreation

@onready var playerVars = get_node("/root/PlayerVariables")
@export var level_manager:LevelManager
@export var player: Player
@export var width: int
@export var height: int
@export var size: int
@export var offset:float
@export_range(0.1, 1.0, 0.05) var enemy_spawn_percent:float

var lvl := 1
const cell = preload("res://Scenes/Cell.tscn")
const enemy = preload("res://Scenes/Enemy.tscn")
const pickable = preload("res://Scenes/Pickable.tscn")
const portal = preload("res://Scenes/Portal.tscn")
const boss = preload("res://Scenes/Boss.tscn")
var cellList:Array
var playerCell:Cell
@export var enemyResources: Array
@export var itemResouces: Array
# Called when the node enters the scene tree for the first time.
func _ready():
	_initialize_scene()
	playerVars.connect("changed_pos",Callable(self,"_move_to_cell"))
	playerVars.connect("reached_portal", Callable(self,"move_to_next_lvl"))
	
func _initialize_scene():
	player._reset_scale()
	cellList.clear()
	for i in get_children():
		i.queue_free()
	get_children().clear()
	create_grid()
	place_player()
	place_elements()
	
func create_grid():
	for i in range(0,width):
		for j in range(0,height):
			var createdCell:Cell = cell.instantiate()
			add_child(createdCell)
			cellList.append(createdCell)
			createdCell.position = Vector3((i+0.5)*size,0,(j+0.5)*size)
			createdCell._set_cell_index(Vector2(i, j))
			
func place_player():
	var bottom_cells = cellList.filter(func(x): return x.cell_index.y == height-1)
	playerCell = bottom_cells.pick_random()
	#print("Player assigned to cell: ", cellList.find(playerCell))
	player.global_position = playerCell.global_position #+ Vector3(0,offset,0)
	cellList.erase(playerCell)
	
	
func place_elements():
	var availableCells = cellList.duplicate()
	var top_cells = availableCells.filter(func(x): return x.cell_index.y == 0)
	var portal_pos = top_cells.pick_random()
	if level_manager._has_boss():
		var boss_instance = boss.instantiate()
		add_child(boss_instance)
		boss_instance.position = portal_pos.position
	else:
		var portal_instance = portal.instantiate()
		add_child(portal_instance)
		portal_instance.position = portal_pos.position
	availableCells.erase(portal_pos)
	
	var number = availableCells.size()*enemy_spawn_percent
	for i in range(number):
		var cell = availableCells.pick_random()
		var enemy_instance = enemy.instantiate()
		add_child(enemy_instance)
		enemy_instance.position = cell.position
		#enemy_instance.enemyData = enemyResources.pick_random()
		enemy_instance.enemyData = level_manager._get_enemy_data()
		enemy_instance._set_enemy()
		availableCells.erase(cell)
		
	for i in availableCells:
		var pick_instance = pickable.instantiate() 
		add_child(pick_instance)
		pick_instance.position = i.position
		#pick_instance.pickData = itemResouces.pick_random()
		pick_instance.pickData = level_manager._get_pickable_data()
		pick_instance._set_item()
		
##Returns an array of the neighboring cells of a cell in the grid (up, down, left and right). May return from 2 to 4 elements.
func _get_neighboring_cells(sel_cell:Cell)->Array[Cell]:
	var near_cell_list:Array[Cell]
	for c in cellList:
		if c.cell_index.x == sel_cell.cell_index.x+1 and c.cell_index.y == sel_cell.cell_index.y: near_cell_list.append(c)
		elif c.cell_index.x == sel_cell.cell_index.x-1 and c.cell_index.y == sel_cell.cell_index.y: near_cell_list.append(c)
		elif c.cell_index.y == sel_cell.cell_index.y+1 and c.cell_index.x == sel_cell.cell_index.x: near_cell_list.append(c)
		elif c.cell_index.y == sel_cell.cell_index.y-1 and c.cell_index.x == sel_cell.cell_index.x: near_cell_list.append(c)
	return near_cell_list
	
#checks if the selected position is within the range of the player - in this case, the distance between cells
func is_cell_in_player_range(sel_cell:Cell) -> bool: 
	#if player.position.distance_to(pos) <= size:
	return _get_neighboring_cells(playerCell).has(sel_cell)
	
	
func _is_any_cell_available(sel_cell:Cell)->bool:
	var no_cell:bool = true
	var near_cell_list := _get_neighboring_cells(sel_cell)

	#for c in cellList:
		#if c.cell_index.x == sel_cell.cell_index.x+1 and c.cell_index.y == sel_cell.cell_index.y: near_cell_list.append(c)
		#elif c.cell_index.x == sel_cell.cell_index.x-1 and c.cell_index.y == sel_cell.cell_index.y: near_cell_list.append(c)
		#elif c.cell_index.y == sel_cell.cell_index.y+1 and c.cell_index.x == sel_cell.cell_index.x: near_cell_list.append(c)
		#elif c.cell_index.y == sel_cell.cell_index.y-1 and c.cell_index.x == sel_cell.cell_index.x: near_cell_list.append(c)
		
	for p in near_cell_list:
		if p.can_pass: no_cell = false
	print("I check ", !no_cell)
	return !no_cell
	
#moves player to cell
func _move_to_cell(my_cell):
	if is_cell_in_player_range(my_cell) && my_cell.can_pass == true:
		cellList.erase(my_cell)
		await player._handle_movement(my_cell.global_position)
		playerCell = my_cell
		if _is_any_cell_available(my_cell) == false:
			playerVars.emit_signal("game_over", false)
	else: print("cant pass")
	
func move_to_next_lvl():
	print("You won")
	level_manager._level_up()
	await player._go_to_portal()
	call_deferred("_initialize_scene")
