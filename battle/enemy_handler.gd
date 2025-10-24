@icon("res://addons/IconGodotNode/color/icon_weapon.png")
extends Node
class_name EnemyHandler

@export var battle_vars : BattleVars
@export var battle_writer : Writer

@onready var enemies : Array[Node] = get_children().filter(get_enemies)

signal dialogue_end()

func get_enemies(node : Node) -> bool:
	return node is BattleEnemy

func _ready() -> void:
	for i in enemies: i.battle_writer = battle_writer

func dialogue():
	match battle_vars.attack_idx:
		_:
			print("Empty dialogue, end fallback")
			dialogue_end.emit()
