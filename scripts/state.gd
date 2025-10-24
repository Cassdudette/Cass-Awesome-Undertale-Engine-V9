@icon("res://addons/IconGodotNode/node/icon_event.png")
extends Node
class_name State

@onready var sm : StateMachine = get_node_or_null("..")

func enter_state():
	pass

func exit_state():
	pass

func state_process():
	pass

func state_physics():
	pass
