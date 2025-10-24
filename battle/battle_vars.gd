@icon("res://addons/IconGodotNode/node/icon_call.png")
class_name BattleVars extends Node

@export var attack_idx : int
@export var healing_attack : bool = false
@export var player_save : PlayerSave = PlayerSave.new()

@export var kr : bool

func _ready() -> void:
	#player_save = PlayerSave.load_data()
	#player_save = PlayerSave.new()
	player_save.hp = 20
	player_save.maxhp = 20
	player_save.lv = 1
	player_save.player_atk = 10
	player_save.player_def = 10
	player_save.player_name = "Cassyi"
	player_save.weapon = RealKnife.new()
	player_save.inventory = [
		ButtsPie.new(),
		ButtsPie.new(),
		ButtsPie.new(),
	]
	#player_save.save_data()
