extends State

@export var battle_vars : BattleVars
@export var label_handler : Node
@export var heart : PlayerHeart
@export var writer : Writer

var target : BattleEnemy
var act_pick : int = 0

func clear_labels():
	for i in label_handler.get_children():
		i.queue_free()

func enter_state():
	act_pick = 0
	var acts : Dictionary[String, Callable] = target.act_options
	for i in acts.size():
		var act_option_label : Label = Label.new()
		act_option_label.global_position = Vector2(101 if i < 3 else 341, 269 + 39 * (i % 3))
		act_option_label.text = "* " + acts.keys()[i]
		act_option_label.label_settings = load("res://themes/battle_enemy_label.tres")
		label_handler.add_child(act_option_label)

func state_process():
	var labels : Array[Node] = label_handler.get_children()

	act_pick += int(Input.is_action_just_pressed("down"))
	act_pick += int(Input.is_action_just_pressed("right")) * 3
	act_pick -= int(Input.is_action_just_pressed("up"))
	act_pick -= int(Input.is_action_just_pressed("left")) * 3
	
	act_pick = posmod(act_pick, labels.size())
	if (Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down")) and labels.size() != 1: 
		SoundManager.play_sound(load("res://assets/audio/menu/menu_move.wav"))
	elif (Input.is_action_just_pressed("right") or Input.is_action_just_pressed("left")) and labels.size() != 1: 
		SoundManager.play_sound(load("res://assets/audio/menu/menu_move.wav"))

	heart.global_position = labels[act_pick].global_position + Vector2(-28, 17)

	if Input.is_action_just_pressed("accept"):
		target.act_options.values()[act_pick].call()
		var acting_state : State = $"../acting"
		acting_state.target = target
		sm.switch_state(acting_state)

	if Input.is_action_just_pressed("cancel"):
		sm.switch_state($"../in_actbutton")

func exit_state():
	clear_labels()
