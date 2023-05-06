extends StaticBody2D

export(String, FILE, "*.tscn") var item = "res://Pickups/Key.tscn"

onready var sprite = $Sprite
onready var area = $Area2D

func _ready():
	add_to_group("Persist")

func _input(event):
	if not sprite.frame == 0: return
	if not area.get_overlapping_bodies().size() > 0: return
	if event.is_action_pressed("ui_cancel"):
		sprite.frame = 1
		SoundPlayer.play("res://Music and Sounds/Oracle_Chest.wav")
		print(str("There was an ", item, " in the chest!"))
		if item == "res://Pickups/Key.tscn":
			PlayerStats.keys += 1

func save():
	var save_dict = {
		"filename": get_filename(),
		"parent": get_parent().get_path(),
		"pos_x": position.x,
		"pos_y": position.y,
		"name": name,
		"opened": sprite.frame == 1
	}
	return save_dict

func load_game(data):
	sprite.frame = 1 if data["opened"] else 0
