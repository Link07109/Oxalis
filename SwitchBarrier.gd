extends StaticBody2D

export(String) var node_name = "FloorSwitch"

var connected = false

func _ready():
	add_to_group("Persist")

func _process(_delta):
	if connected: return
	var node = get_parent().find_node("*"+node_name+"*", true, false)
	if node:
		node.connect("activated", self, "unlock")
		connected = true
	
func unlock():
	SoundPlayer.play("res://Music and Sounds/Oracle_Secret.wav")
	queue_free()

func save():
	var save_dict = {
		"filename": get_filename(),
		"parent": get_parent().get_path(),
		"pos_x": position.x,
		"pos_y": position.y,
		"name": name,
		"switch_name": node_name,
	}
	return save_dict

func load_game(data):
	node_name = data["switch_name"]
