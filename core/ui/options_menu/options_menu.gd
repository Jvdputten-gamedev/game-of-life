class_name OptionsMenu
extends Control

@export var back_button: Button
@export var settings_tab_container: SettingsTabContainer

signal exit_options_menu

func _ready():
	back_button.button_down.connect(_on_back_button_down)
	settings_tab_container.exit_options_menu.connect(_on_back_button_down)
	set_process(false)

func enable():
	set_process(true)
	visible = true

func _on_back_button_down():
	exit_options_menu.emit()
	visible = false
	set_process(false)
