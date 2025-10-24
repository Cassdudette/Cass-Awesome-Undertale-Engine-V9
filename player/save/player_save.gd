extends Resource
class_name PlayerSave

const SAVE_PATH = "user://player_save.tres"

@export var player_name : String = "Cassyi"
@export var inventory : Array[Item] = [
	
]
@export var weapon : Item

@export var player_atk : int = 10
@export var player_def : int = 10

@export var hp : int
@export var maxhp : int
@export var lv : int
@export var kr : int

func _init() -> void:
	player_name = "null"
	inventory = [
		ButtsPie.new(),
		null,
		null,
		null,
		null,
		null,
		null,
		null,
	]
	weapon = RealKnife.new()
	player_atk = 1
	player_def = 1

## Returns the heal message
func heal(heal_amount : int) -> String:
	hp = min(maxhp, hp + heal_amount)
	if hp == maxhp: 
		return "* Your HP was maxed out!"
	else: 
		return "* You recovered " + str(heal_amount) + " HP!"

func save_data(): 
	ResourceSaver.save(self, SAVE_PATH)

static func load_data():
	return load(SAVE_PATH)
