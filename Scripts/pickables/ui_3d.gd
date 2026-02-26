extends Node3D
class_name Ui3D

@export var billboard:Sprite3D
@export var type_icon:TextureRect
@export var name_text:Label 
@export var type_text:Label
@export var quantity_text:Label
@export var tween_time:float

func _show_ui():
	billboard.visible = true
	var tween = create_tween()
	tween.tween_property(billboard,"scale", Vector3.ONE, tween_time).from(Vector3(0.1,0.1,0.1)).set_trans(Tween.TRANS_BOUNCE)
	
func _hide_ui():
	var tween = create_tween()
	tween.tween_property(billboard,"scale", Vector3(0.1,0.1,0.1), tween_time).from(Vector3.ONE)
	await tween.finished
	billboard.visible = false
	
func _set_ui(type:String, quantity:String, icon:Texture2D = null, res_name:String = ""):
	if res_name!="": name_text.text = res_name
	else: name_text.visible = false
	type_text.text = type
	quantity_text.text = quantity
	if icon!=null: type_icon.texture = icon
	
func _update_ui(quantity:String):
	quantity_text.text = quantity
	
