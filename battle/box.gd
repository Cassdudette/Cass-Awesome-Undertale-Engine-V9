@icon("res://addons/IconGodotNode/control/icon_crate.png")
extends Panel
class_name HUDBattleBox 

# Resizing speed
var move_toward_delta : float = 10
# Resizing target
var target_offsets : Array[int] = [240, 400, 250, 390]
# Used to check if resize is done
var resize_done : bool = false

func _process(_delta: float) -> void:
	$body/left_wall.position = Vector2(3, size.y / 2)
	$body/left_wall.shape.size = Vector2(6, size.y)
	$body/right_wall.position = Vector2(size.x - 3, size.y / 2)
	$body/right_wall.shape.size = Vector2(6, size.y)
	$body/top_wall.position = Vector2(size.x / 2, 3)
	$body/top_wall.shape.size = Vector2(size.x, 6)
	$body/bottom_wall.position = Vector2(size.x / 2, size.y - 3)
	$body/bottom_wall.shape.size = Vector2(size.x, 6)

	offset_left = move_toward(offset_left, target_offsets[0], move_toward_delta)
	offset_right = move_toward(offset_right, target_offsets[1], move_toward_delta)
	offset_top = move_toward(offset_top, target_offsets[2], move_toward_delta)
	offset_bottom = move_toward(offset_bottom, target_offsets[3], move_toward_delta)

	pivot_offset = size / 2

	#rotation_degrees += 1

	resize_done = false
	if offset_left == target_offsets[0] and offset_right == target_offsets[1]:
		if offset_top == target_offsets[2] and offset_bottom == target_offsets[3]:
			resize_done = true
