extends State

@export var heart : PlayerHeart
@export var box : HUDBattleBox
@export var enemy_handler : EnemyHandler

var attacks : Array[Attack] = [
	Attack.new()
]

func enter_state():
	var attack : Attack = attacks[posmod(sm.battle_vars.attack_idx, attacks.size())].duplicate()
	attack.heart = heart
	attack.box = box
	attack.enemy_handler = enemy_handler
	attack.attack_started.connect(func(): sm.switch_state($"../dodging"))
	attack.attack_ended.connect(
		func(): 
			sm.switch_state($"../in_buttons")
			attack.queue_free())
	add_child(attack)
	attack.pre_attack()
