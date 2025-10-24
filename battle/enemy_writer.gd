extends Writer

func _process(_delta: float) -> void:
	super(_delta)
	get_parent().size.y = get_content_height() + 24
