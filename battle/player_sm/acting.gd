extends State

@export var battle_vars : BattleVars
@export var heart : PlayerHeart
@export var battle_writer : Writer

var target : BattleEnemy

func enter_state():
	heart.hide()
	await target.acting_done
	if battle_vars.healing_attack:
		sm.switch_state($"../pre_healing_attack")
	else:
		sm.switch_state($"../in_buttons")

func exit_state():
	if battle_vars.healing_attack:
		battle_writer.hide()
	else:
		battle_writer.show()
