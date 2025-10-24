@icon("res://addons/IconGodotNode/node_2D/icon_bone.png")
extends Node2D
class_name BattleEnemy

@export var hit_marker : Marker2D
@export var enemy_name : String = "Sans"
@export var enemy_def : int = 1
@export var max_hp = 5000
@export var hp = 5000

var battle_writer : Writer
var act_options : Dictionary[String, Callable] = {
	"Check0" : test_check,
	"Check1" : test_check,
	"Check2" : test_check,
	"Check3" : test_check,
	"Check4" : test_check,
	"Check5" : test_check
}

signal acting_done()

func _ready() -> void:
	var hp_bar : ProgressBar = $hp_bar
	hp_bar.max_value = max_hp
	hp_bar.value = hp

func damage(damage_amount : float):
	hp -= damage_amount

	var damage_label : Label = $damage_label
	damage_label.modulate.a = 1

	if damage_amount == 0:
		damage_label.text = "MISS"
		damage_label.label_settings.font_color = Color("b1b1b1")
	else:
		damage_label.text = str(roundi(damage_amount))
		damage_label.label_settings.font_color = Color.RED
		SoundManager.play_sound(load("res://assets/audio/battle/hit.wav"))

	var tw : Tween = create_tween()
	tw.tween_property(damage_label, "position:y", damage_label.position.y - 20, .2).set_trans(Tween.TRANS_QUAD)
	tw.tween_property(damage_label, "position:y", damage_label.position.y, 1).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(damage_label, "modulate:a", 0, .7)

	var hp_bar : ProgressBar = $hp_bar
	hp_bar.modulate.a = 1

	var tw2 = create_tween()
	tw2.tween_property(hp_bar, "value", hp, .7)
	tw2.tween_property(hp_bar, "modulate:a", 0, .7)

func test_check():
	battle_writer.text_field = "* test act - 20 ATK 20 DEF\n* idk"
	battle_writer.show()
	await battle_writer.writer_done
	acting_done.emit()
