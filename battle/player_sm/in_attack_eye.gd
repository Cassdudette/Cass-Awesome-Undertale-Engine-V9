extends State

@export var battle_vars : BattleVars
@export var eye_handler : EyeHandler
@export var enemy_handler : EnemyHandler

@onready var enemies : Array[Node] = enemy_handler.enemies

var target : BattleEnemy

func enter_state():
	var eye : RealKnifeEye = preload("res://player/items/weapons/real_knife_eye.tscn").instantiate()
	eye.global_position = Vector2(320, 320) - Vector2(274, 58)
	eye_handler.add_child(eye)
	eye.target = target
	eye.player_atk = battle_vars.player_save.player_atk
	eye.start()
	await eye.hit_ended
	sm.switch_state($"../pre_attack")
