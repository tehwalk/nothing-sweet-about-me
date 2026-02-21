extends Node
enum PickType {HEALTH, WEAPON, SHIELD, GOLD}

signal changed_pos(cell)
signal cell_destroyed
signal hit_enemy(points, action)
signal get_xp(points)
signal item_picked(type, points)
signal reached_portal
signal game_over(won:bool)

signal confirm_quit
signal cancel_quit
