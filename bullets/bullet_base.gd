@icon("res://addons/IconGodotNode/node_2D/icon_bullet.png")
extends Node2D
class_name BulletBase

@export var damage : int
@export var kr : int

@export var hitbox : Area2D
@export var direction : Vector2
@export var speed : float

func _process(_delta: float) -> void:
	global_position += speed * direction

	for i in hitbox.get_overlapping_areas():
		if i.is_in_group("player_hitbox"):
			i.get_parent().damage(damage)
