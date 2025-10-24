@icon("res://addons/IconGodotNode/control/icon_dice.png")
class_name RealKnifeEye
extends TextureRect

var damage : float = 0
var target : BattleEnemy
var player_atk : int = 1

signal hit_ended()

func start():
	var tw : Tween = create_tween().set_parallel()
	tw.tween_property(self, "scale:x", 1, 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT).from(.7)
	tw.tween_property(self, "modulate:a", 1, 1).from(.7)

	#await tw.finished
	await get_tree().process_frame

	var hit_bar : AnimatedSprite2D = $hit_bar
	hit_bar.position = Vector2(0, 320)
	hit_bar.show()
	tw = create_tween()
	tw.tween_property(hit_bar, "position", Vector2(640, 320), 2.5).from(Vector2(0, 320))

	while tw.is_running():
		if Input.is_action_just_pressed("accept"):
			damage = round(player_atk - target.enemy_def + randf_range(0, 2) + (1 - hit_bar.global_position.distance_to(Vector2(320, 320)) / 320) * 2 * 100)
			hit_bar.play()
			tw.stop()
			break
		else:
			await get_tree().process_frame

	if damage != 0:
		SoundManager.play_sound(load("res://assets/audio/weapons/strike.wav"))
		var slash : AnimatedSprite2D = $slash
		slash.global_position = target.hit_marker.global_position
		
		slash.show()
		slash.play()

		await slash.animation_finished

		slash.queue_free()

	target.damage(damage)

	tw = create_tween().set_parallel()
	tw.tween_property(self, "scale:x", 0, 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(self, "modulate:a", 0, 1)
	tw.tween_property(hit_bar, "modulate:a", 0, 1)
	await get_tree().create_timer(1).timeout

	hit_ended.emit()
	queue_free()
