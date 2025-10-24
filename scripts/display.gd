extends Node2D

@export var default_scene : PackedScene
@export var game_socket : Node2D

var fullscreen_toggle : bool = false

func _ready() -> void:
	change_scene(default_scene)
	RenderingServer.set_default_clear_color(Color.BLACK)

func change_scene(new_scene : PackedScene):
	for i in game_socket.get_children(): i.queue_free()
	game_socket.add_child(new_scene.instantiate())

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("F2"): 
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("F4"):
		fullscreen_toggle = not fullscreen_toggle
		if fullscreen_toggle:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
