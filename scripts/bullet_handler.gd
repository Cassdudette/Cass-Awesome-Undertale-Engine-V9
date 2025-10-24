extends Node

@export var box : HUDBattleBox
@export var mask : Control

func spawn_sans_bone(pos : Vector2, speed : float, offset_top : int, offset_bottom : int, clip : bool = true):
	var inst : SansBone = preload("res://bullets/sans/sans_bone.tscn").instantiate()
	inst.speed = speed
	inst.sprite.offset_top = offset_top
	inst.sprite.offset_bottom = offset_bottom
	if clip: mask.add_child(inst)
	else: box.add_child(inst)
	inst.global_position = pos
