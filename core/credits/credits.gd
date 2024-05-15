extends Control

@export var bg_color : Color = Color.BLACK
@export var title_color := Color.BLUE
@export var text_color := Color.WHITE
@export var title_font : FontFile = null
@export var text_font : FontFile = null
@export var Music : AudioStream = null
@export var Use_Video_Audio : bool = false
@export var video : VideoStream = null

const base_speed := 5000
const speed_up_multiplier := 5.0
const main_menu_scene_path = "res://core/ui/main_menu/main_menu.tscn"

var scroll_speed : float = base_speed
var speed_up := false

@onready var colorrect := $ColorRect
@onready var videoplayer := $VideoPlayer
@onready var credits_text := $CreditsContainer/RichTextLabel as RichTextLabel

var credits = [
	{"title": "Programmers", "content": "Programmer Name 1\nProgrammer Name 2"},
	{"title": "Art", "content": "Artist Name"},
	{"title": "Music", "content": "Musician Name"},
	{"title": "Sound Effects", "content": "SFX Name"},
	{"title": "Testers", "content": "Name 1\nName 2\nName 3"},
	{"title": "Tools used", "content": "Developed with [url=https://godotengine.org/license]Godot Engine[/url]\n"},
	{"title": "Special thanks", "content": "My parents\nMy friends\nMy pet dragon"}
]

func _ready():
	colorrect.color = bg_color
	videoplayer.set_stream(video)
	if !Use_Video_Audio:
		var stream = AudioStreamPlayer.new()
		stream.set_stream(Music)
		add_child(stream)
		videoplayer.set_volume_db(-80)
		stream.play()
	else:
		videoplayer.set_volume_db(0)
	videoplayer.play()
	credits_text.clear()
	credits_text.push_paragraph(HORIZONTAL_ALIGNMENT_CENTER)
	for section in credits:
		add_section(section)
	credits_text.pop()
	credits_text.position.y = max(credits_text.size.y, DisplayServer.window_get_size().y)
	

func add_section(section: Dictionary):
	credits_text.push_color(title_color)
	credits_text.push_bold()
	credits_text.add_text(section["title"] + "\n")
	credits_text.pop()
	credits_text.pop()
	credits_text.append_text(section["content"] + "\n\n")

func _process(delta):
	scroll_speed = base_speed * delta
	
	if speed_up:
		scroll_speed *= speed_up_multiplier
	if credits_text.position.y < -credits_text.size.y:
		finish()
	else:
		credits_text.position.y -= scroll_speed * delta

func finish():
	SceneManager.fade(main_menu_scene_path)


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		finish()
	if event.is_action_pressed("ui_down") and !event.is_echo():
		speed_up = true
	if event.is_action_released("ui_down") and !event.is_echo():
		speed_up = false
