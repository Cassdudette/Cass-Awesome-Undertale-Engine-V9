@icon("res://addons/IconGodotNode/node/icon_brain.png")
extends Node
class_name StateMachine 

@export var initial_state : State
var states : Array[State] = []
var current_state : State

func switch_state(new_state : State):
	current_state.exit_state()
	current_state = new_state
	print("State machine: ", self, " switched to state: ", new_state)
	new_state.enter_state()

func _ready() -> void:
	# Gather all children states
	for i in get_children():
		if i is State:
			states.append(i)
	current_state = initial_state
	current_state.enter_state()

func _process(_delta: float) -> void:
	if current_state: 
		current_state.state_process()

func _physics_process(_delta: float) -> void:
	if current_state:
		current_state.state_physics()
