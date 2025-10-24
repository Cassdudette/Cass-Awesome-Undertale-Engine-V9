extends State

@export var heart : PlayerHeart
@export var label_handler : Node
@export var battle_vars : BattleVars

var selected_page : int = 1
var item_pick : int

class ItemLabel:
	extends Label
	func _init() -> void:
		label_settings = load("res://themes/battle_enemy_label.tres")

func create_item_labels():
	for i in label_handler.get_children(): i.queue_free()
	var inventory : Array[Item] = battle_vars.player_save.inventory
	# Create item labels
	for row in 2: for col in 2: 
		var i : int = row * 2 + col + (selected_page - 1) * 4
		if inventory.size() > i:
			var label : Label = ItemLabel.new()
			label.text = "* " + inventory[i].item_name
			label_handler.add_child(label)
			label.global_position = Vector2(101 if col < 1 else 340, 271 + row * 31)
	# Create page label
	if inventory.size() > 4:
		var page_label : Label = Label.new()
		page_label.text = "PAGE " + str(selected_page)
		page_label.label_settings = load("res://themes/battle_enemy_label.tres")
		label_handler.add_child(page_label)
		page_label.global_position = Vector2(388, 334)

func enter_state():
	if !battle_vars.player_save.inventory: 
		sm.switch_state($"../in_buttons")
	else:
		create_item_labels()

func state_process():
	item_pick += int(Input.is_action_just_pressed("down")) * 2
	item_pick -= int(Input.is_action_just_pressed("up")) * 2
	
	var inventory_size : int = battle_vars.player_save.inventory.size()
	# Change page
	if inventory_size > 4:
		if Input.is_action_just_pressed("right") and selected_page == 1 and (item_pick == 1 or item_pick == 3):
			selected_page = 2
			item_pick = clamp(item_pick - 1, 0, inventory_size - 4)
			create_item_labels()
		elif Input.is_action_just_pressed("right"):
			item_pick += 1
		if Input.is_action_just_pressed("left") and selected_page == 2 and (item_pick == 0 or item_pick == 2): 
			selected_page = 1
			item_pick = clamp(item_pick + 1, 0, inventory_size - 4)
			create_item_labels()
		elif Input.is_action_just_pressed("left"):
			item_pick -= 1
		if selected_page == 1:
			item_pick = posmod(item_pick, 4)
		elif selected_page == 2:
			item_pick = posmod(item_pick, min(4, inventory_size - 4))
	else:
		if Input.is_action_just_pressed("right"): 
			item_pick += 1
		if Input.is_action_just_pressed("left"): 
			item_pick -= 1
		item_pick = posmod(item_pick, min(4, inventory_size))

	var item_labels : Array[Node] = label_handler.get_children().filter(
		func(node): 
			if node is ItemLabel: 
				return true)

	if (Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down")) and item_labels.size() != 1: 
		SoundManager.play_sound(load("res://assets/audio/menu/menu_move.wav"))
	elif (Input.is_action_just_pressed("right") or Input.is_action_just_pressed("left")) and item_labels.size() != 1: 
		SoundManager.play_sound(load("res://assets/audio/menu/menu_move.wav"))

	heart.global_position = item_labels[item_pick].global_position + Vector2(-28, 17)

	if Input.is_action_just_pressed("cancel"):
		sm.switch_state($"../in_buttons")

	if Input.is_action_just_pressed("accept"):
		var item_use_state : State = $"../item_use"
		item_use_state.item_idx = item_pick + (selected_page - 1) * 4
		sm.switch_state(item_use_state)

func exit_state():
	for i in label_handler.get_children():
		i.queue_free()
