@icon("res://addons/IconGodotNode/node/icon_stat.png")
extends Node

@export var battle_vars : BattleVars

@onready var player_save : PlayerSave = battle_vars.player_save

func _ready():
	$name.text = player_save.player_name
	$lv_amount.text = "LV " + str(player_save.lv)
	$hp_bar.max_value = player_save.maxhp
	$hp_bar.size.x = player_save.maxhp * 1.11
	if battle_vars.kr:
		$kr_label.show()
		$kr_label.global_position.x = $hp_bar.global_position.x + $hp_bar.size.x + 9
		$hp_amount.global_position.x = $kr_label.global_position.x + 40
	else:
		$kr_label.hide()
		$hp_amount.global_position.x = $hp_bar.global_position.x + $hp_bar.size.x + 9
	

func _process(_delta: float) -> void:
	$hp_amount.text = str(player_save.hp) + " / " + str(player_save.maxhp)
	$hp_bar.value = player_save.hp - player_save.kr
	$hp_bar/kr_amount.size.x = player_save.kr * 1.11
	$hp_bar/kr_amount.global_position.x = $hp_bar.global_position.x + player_save.hp * 1.11
