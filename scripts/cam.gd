extends Camera2D
class_name Cam

func shake(duration : int):
	for i in duration:
		offset.x += randf_range(-1, 1)
		offset.y += randf_range(-1, 1)
		await get_tree().process_frame
	offset = Vector2.ZERO
