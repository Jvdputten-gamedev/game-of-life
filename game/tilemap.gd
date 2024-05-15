extends TileMap


# Called when the node enters the scene tree for the first time.
enum Layers {FOREGROUND=0, BACKGROUND=1, HIGHLIGHT=2}

@onready var num_rows = get_used_rect().end[1]
@onready var num_cols = get_used_rect().end[0]
@export var step_button: Button
@export var clear_button: Button
@export var play_button: Button
@export var stop_button: Button
@export var timer: Timer

func _ready():
	print(get_used_rect())
	step_button.pressed.connect(step)
	clear_button.pressed.connect(clear_map)
	play_button.pressed.connect(play)
	stop_button.pressed.connect(stop)


func play():
	timer.timeout.connect(step)
	timer.start()
	play_button.visible = false
	stop_button.visible = true

func stop():
	timer.timeout.disconnect(step)
	play_button.visible = true
	stop_button.visible = false



func clear_highlight() -> void:
	clear_layer(Layers.HIGHLIGHT)

func clear_map() -> void:
	clear_layer(Layers.FOREGROUND)

func cell_in_play_area(cell: Vector2i) -> bool:
	return get_used_rect().has_point(cell)

func paint_highlight_on_map(cell: Vector2i):
	if cell_in_play_area(cell):
		set_cell(Layers.HIGHLIGHT, cell, 3, Vector2i(0,0))

func paint_cell(cell: Vector2i):
	if cell_in_play_area(cell):
		set_cell(Layers.FOREGROUND, cell, 1, Vector2i(0,0))

func clear_cell(cell: Vector2i):
	set_cell(Layers.FOREGROUND, cell)

func is_alive(cell: Vector2i):
	return get_cell_atlas_coords(Layers.FOREGROUND, cell) == Vector2i(0,0)

func count_neighbors(cell: Vector2i):
	var surrounding_cells: Array[Vector2i] = get_surrounding_cells(cell)
	surrounding_cells.append(Vector2i(-1,-1) + cell)
	surrounding_cells.append(Vector2i(1,1) + cell)
	surrounding_cells.append(Vector2i(-1,1) + cell)
	surrounding_cells.append(Vector2i(1,-1) + cell)

	var count: int = 0
	for neighbor in surrounding_cells:
		if is_alive(neighbor):
			count+=1
	
	return count

func step():
	var count
	var buffer_index: int = 0
	var buffer_array: = []
	for row in num_rows:
		for col in num_cols:
			var cur_cell = Vector2i(row, col)
			count = count_neighbors(cur_cell)
			if is_alive(cur_cell):
				if count < 2 or count > 3:
					buffer_array.append(false)
				else:
					buffer_array.append(true)
			else:
				if count == 3:
					buffer_array.append(true)
				else:
					buffer_array.append(false)
	
	buffer_index = 0
	for row in num_rows:
		for col in num_cols:
			
			if buffer_array[buffer_index]:
				paint_cell(Vector2i(row, col))
			else:
				clear_cell(Vector2i(row, col))
			buffer_index += 1

	if len(get_used_cells(Layers.FOREGROUND)) == 0:
		stop()


				
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		clear_highlight()
		var cell_coord: Vector2i = local_to_map(get_local_mouse_position())
		paint_highlight_on_map(cell_coord)

	if event is InputEventMouseButton:
		var cell_coord: Vector2i = local_to_map(get_local_mouse_position())
		if event.button_index == 1 and event.pressed:
			paint_cell(cell_coord)
			count_neighbors(cell_coord)

		if event.button_index == 2 and event.pressed:
			clear_cell(cell_coord)



