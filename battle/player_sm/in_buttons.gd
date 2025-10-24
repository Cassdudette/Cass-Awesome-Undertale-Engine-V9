extends State

@export var battle_vars : BattleVars
@export var heart : PlayerHeart
@export var box : HUDBattleBox
@export var buttons : Array[AnimatedSprite2D]
@export var writer : Writer
@export var flavor_text : String = "* Placeholder flavor text"

var button_index : int = 0

func set_flavor_text():
	while !box.resize_done: 
		await get_tree().process_frame 
	match battle_vars.attack_idx:
		_:
			flavor_text = "* Placeholder flavor text"
	writer.text_field = flavor_text

func enter_state():
	box.target_offsets = [33, 609, 250, 390]
	set_flavor_text()
	writer.show()
	heart.show()

func state_process():
	button_index += int(Input.is_action_just_pressed("right"))
	button_index -= int(Input.is_action_just_pressed("left"))
	button_index = posmod(button_index, buttons.size())
	if (Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right")) and buttons.size() != 1: 
		SoundManager.play_sound(load("res://assets/audio/menu/menu_move.wav"))

	for i in buttons.size():
		if i == button_index:
			buttons[i].frame = 1
			heart.global_position = buttons[i].global_position - Vector2(39, 0)
		else:
			buttons[i].frame = 0

	if Input.is_action_just_pressed("accept"):
		SoundManager.play_sound(load("res://assets/audio/menu/menu_select.wav"))
		if buttons[button_index] is ButtonFight:
			sm.switch_state($"../in_fightbutton")
		if buttons[button_index] is ButtonAct:
			sm.switch_state($"../in_actbutton")
		if buttons[button_index] is ButtonItem:
			sm.switch_state($"../in_itemsbutton")

func exit_state():
	writer.hide()
	for i in buttons: 
		i.frame = 0
