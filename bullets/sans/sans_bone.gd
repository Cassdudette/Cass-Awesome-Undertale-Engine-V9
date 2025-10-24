extends BulletBase
class_name SansBone

@export var sprite : NinePatchRect

func _process(_delta: float) -> void:
	super(_delta)
	$hitbox/collision.global_position = sprite.size / 2
	$hitbox/collision.shape.size = Vector2(4, sprite.size.y - 8)
