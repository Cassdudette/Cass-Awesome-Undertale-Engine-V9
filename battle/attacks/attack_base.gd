extends Node
class_name Attack

@export var heart : PlayerHeart
@export var box : HUDBattleBox
@export var enemy_handler : EnemyHandler

var attack_length : float = 2

signal attack_started()
signal attack_ended()

func pre_attack():
	box.target_offsets = [240, 400, 250, 390]
	heart.global_position = Vector2(320, 320)
	heart.show()
	enemy_handler.dialogue_end.connect(start_attack)
	enemy_handler.dialogue()

func start_attack():
	attack_started.emit()
	bullets()
	get_tree().create_timer(attack_length).timeout.connect(end_attack)

# Attack implementation here
func bullets():
	pass

func end_attack():
	attack_ended.emit()
