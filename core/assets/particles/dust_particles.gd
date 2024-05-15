extends GPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var size = DisplayServer.window_get_size()
	global_position = Vector2(size.x*0.5, size.y*0.5)
	process_material.emission_box_extents = Vector3(size.x*1.1, size.y*1.1, 1)


