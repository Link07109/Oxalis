extends TileMap
 
var finished = false

func _process(_delta):
	if finished: return
	
	var size = cell_size
	var offset = size / 2
	for tile in get_used_cells():
		var name = tile_set.tile_get_name(get_cell(tile.x, tile.y))
		var node = load(str("res://Pickups/", name, ".tscn")).instance()
		node.global_position = tile * size + offset
		get_parent().call_deferred("add_child", node)
	
	finished = true
	visible = false

func save():
	var save_dict = {
		"filename": get_filename(),
		"parent": get_parent().get_path(),
		"pos_x": position.x,
		"pos_y": position.y,
		"name": name,
		"finished": finished
	}
	return save_dict

func load_game(data):
	finished = data["finished"]
