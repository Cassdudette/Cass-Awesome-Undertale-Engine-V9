@icon("res://addons/IconGodotNode/control/icon_parchment.png")
extends RichTextLabel
class_name Writer

# Text properties
var sound : String = "main0"
var font : String = "main0" : 
	set(value):
		font = value
		add_theme_font_override("normal_font", font_dict[value])
var skip_enabled : bool

# Statics
static var font_dict : Dictionary[String, Font] = {
	"main0" : load("res://assets/fonts/main.ttf"),
}

static var sound_dict : Dictionary[String, AudioStream] = {
	"main0" : load("res://assets/audio/characters/mono1.wav"),
	"main1" : load("res://assets/audio/characters/mono2.wav"),
}

var timer : Timer = Timer.new()
var read_speed : float = .05
var text_field : String : 
	set(value):
		if !is_node_ready(): await ready
		text = value
		_write()

signal writer_done

func _ready() -> void: 
	add_child(timer)

func _write():
	visible_characters = 0
	while visible_characters < text.length():
		visible_characters += 1
		var get_char : String = text[visible_characters - 1]
		if get_char != " " and get_char != "!" and get_char != "." and get_char != "?":
			SoundManager.play_sound(sound_dict[sound])
		timer.start(read_speed)
		await timer.timeout

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("accept") and visible_characters == text.length():
		writer_done.emit()
	if Input.is_action_just_pressed("cancel") and skip_enabled:
		visible_characters = text.length()
