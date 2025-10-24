@icon("res://addons/IconGodotNode/node_2D/icon_heart.png")
extends CharacterBody2D
class_name PlayerHeart

@export var hitbox : Area2D
@export var camera : Cam
@export var battle_vars : BattleVars
@export var shake_on_hit : bool = false

var speed : float = 150

func damage(damage_amount : int):
	battle_vars.player_save.hp -= damage_amount
	SoundManager.play_sound(load("res://assets/audio/battle/hurt.wav"))
	if shake_on_hit:
		camera.shake(6)
	print("Player HP is now: ", battle_vars.player_save.hp)
