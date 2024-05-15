extends TileMap


# Called when the node enters the scene tree for the first time.
enum Layers {FOREGROUND=0, BACKGROUND=1, HIGHLIGHT=2}

func clear_highlight() -> void:
	clear_layer(Layers.HIGHLIGHT)

func paint_highlight_on_map(cell: Vector2i):
	set_cell(Layers.HIGHLIGHT, cell, 3, Vector2i(0,0))

func paint_cell(cell: Vector2i):
	set_cell(Layers.FOREGROUND, cell, 1, Vector2i(0,0))

func clear_cell(cell: Vector2i):
	set_cell(Layers.FOREGROUND, cell)

func count_neighbors(cell: Vector2i):
	var surrounding_cells: Array[Vector2i] = get_surrounding_cells(cell)
	surrounding_cells.append(Vector2i(-1,-1) + cell)
	surrounding_cells.append(Vector2i(1,1) + cell)
	surrounding_cells.append(Vector2i(-1,1) + cell)
	surrounding_cells.append(Vector2i(1,-1) + cell)

	var count: int = 0
	for neighbor in surrounding_cells:
		if get_cell_atlas_coords(Layers.FOREGROUND, neighbor) == Vector2i(0,0):
			count+=1
	
	return count






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



