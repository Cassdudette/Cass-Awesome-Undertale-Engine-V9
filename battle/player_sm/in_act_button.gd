extends State

@export var heart : PlayerHeart
@export var enemy_handler : EnemyHandler

@onready var label_handler : Node = get_node("label_handler")

var enemy_pick : int = 0
var enemies : Array[Node]

func clear_labels():
	for i in label_handler.get_children():
		i.queue_free()

func enter_state():
	enemies = enemy_handler.enemies
	for i : BattleEnemy in enemies:
		var enemy_name_label : Label = Label.new()
		enemy_name_label.global_position = Vector2(101, 269 + i.get_index() * 39)
		enemy_name_label.text = "* " + i.enemy_name
		enemy_name_label.label_settings = load("res://themes/battle_enemy_label.tres")
		label_handler.add_child(enemy_name_label)

func state_process():
	var labels : Array[Node] = label_handler.get_children()

	enemy_pick += int(Input.is_action_just_pressed("down"))
	enemy_pick -= int(Input.is_action_just_pressed("up"))
	enemy_pick = posmod(enemy_pick, labels.size())
	if (Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down")) and labels.size() != 1: 
		SoundManager.play_sound(load("res://assets/audio/menu/menu_move.wav"))

	heart.global_position = labels[enemy_pick].global_position + Vector2(-28, 17)

	if Input.is_action_just_pressed("accept"):
		var act_option_state : State = $"../act_options"
		act_option_state.target = enemies[enemy_pick]
		sm.switch_state(act_option_state)
	if Input.is_action_just_pressed("cancel"):
		sm.switch_state($"../in_buttons")

func exit_state():
	clear_labels()
