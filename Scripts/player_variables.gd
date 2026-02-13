extends Node
enum PickType {HEALTH, WEAPON, SHIELD, GOLD}

signal changed_pos(cell)
signal cell_destroyed
signal hit_enemy(points, is_boss:bool)
signal item_picked(type, points)
signal reached_portal
signal game_over(won:bool)
