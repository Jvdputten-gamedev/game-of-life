extends Node


@export var click_sound: AudioStreamPlayer
@export var hover_sound: AudioStreamPlayer

func connect_ui_elements(node):
	for child in node.get_children():

		if child is Button:
			child.mouse_entered.connect(func(): hover_sound.play())
			child.pressed.connect(func(): click_sound.play())

		if child is Range:
			child.mouse_entered.connect(func(): hover_sound.play())
			child.drag_started.connect(func(): click_sound.play())		
			child.drag_ended.connect(_on_range_drag_ended)		

		if child is TabContainer:
			child.tab_hovered.connect(_on_tab_hovered)
			child.tab_selected.connect(_on_tab_clicked)


		connect_ui_elements(child)

func _on_range_drag_ended(_value_changed: bool):
	if _value_changed:
		click_sound.play()

func _on_tab_clicked(_tab: int):
	click_sound.play()

func _on_tab_hovered(_tab: int):
	hover_sound.play()