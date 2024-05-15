class_name MainMenu
extends Control

@export var start_button: Button
@export var options_button: Button
@export var credits_button: Button
@export var quit_button: Button

@export var options_menu: OptionsMenu
@export var main_menu_container: MarginContainer

const PATH_TO_CREDITS = "res://core/credits/credits.tscn"
const PATH_TO_MAIN_SCENE = "res://core/main.tscn"



func _ready():
	start_button.button_down.connect(_on_start_button_down)
	options_button.button_down.connect(_on_options_button_down)
	credits_button.button_down.connect(_on_credits_button_pressed)
	quit_button.button_down.connect(_on_quit_button_down)
	options_menu.exit_options_menu.connect(_on_exit_options_menu)

	AudioManager.ui_sounds.connect_ui_elements(self)


func _on_start_button_down():
	SceneManager.fade(PATH_TO_MAIN_SCENE)

func _on_options_button_down():
	main_menu_container.visible = false
	options_menu.show()

func _on_quit_button_down():
	get_tree().quit()

func _on_exit_options_menu() -> void:
	main_menu_container.visible = true

func _on_credits_button_pressed() -> void:
	SceneManager.fade(PATH_TO_CREDITS)
