extends State

@export var heart : PlayerHeart
var move_input : Vector2i

func enter_state():
	heart.show()

func state_process():
	move_input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	move_input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))

func state_physics():
	heart.velocity = move_input * heart.speed
	heart.move_and_slide()
