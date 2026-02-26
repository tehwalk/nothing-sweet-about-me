extends Node3D
class_name MeshCluster

@onready var highlight_material:=preload("res://Materials/tile_outline.tres")
@export var meshes:Array[MeshInstance3D]

func _highlight_on():
	for mesh in meshes:
		mesh.material_overlay = highlight_material
		
func _highlight_off():
	for mesh in meshes:
		mesh.material_overlay = null
