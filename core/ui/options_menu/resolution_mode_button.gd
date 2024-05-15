extends Control

@export var option_button: OptionButton


const RESOLUTION: Dictionary = {
	"1152 x 648": Vector2i(1152, 648),
	"1280 x 720": Vector2i(1280, 720),
	"1920 x 1080": Vector2i(1920, 1080)
}

func _ready():
	option_button.item_selected.connect(_on_resolution_selected)
	add_resolution_items()

func add_resolution_items() -> void:
	for resolution_size_text in RESOLUTION:
		option_button.add_item(resolution_size_text)


func _on_resolution_selected(index: int) -> void:
	DisplayServer.window_set_size(RESOLUTION.values()[index])