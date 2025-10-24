extends State

@export var battle_vars : BattleVars
@export var battle_writer : Writer
@export var heart : PlayerHeart
var item_idx : int

func enter_state():
	heart.hide()
	var item : Item = battle_vars.player_save.inventory[item_idx]
	if item is Heal:
		SoundManager.play_sound(load("res://assets/audio/menu/heal.wav"))
		battle_writer.show()
		battle_writer.skip_enabled = true
		battle_writer.text_field = "* You ate the " + str(item.full_item_name) + ".\n" + battle_vars.player_save.heal(item.heal_amount)
		await battle_writer.writer_done
		battle_vars.player_save.inventory.erase(item)
	
	if battle_vars.healing_attack:
		sm.switch_state($"../pre_healing_attack")
	else:
		sm.switch_state($"../in_buttons")

func exit_state():
	battle_writer.skip_enabled = false
	if battle_vars.healing_attack:
		battle_writer.hide()
	else:
		battle_writer.show()
