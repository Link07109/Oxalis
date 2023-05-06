extends StaticBody2D

onready var level = get_parent().get_parent()
onready var anim = $AnimationPlayer

var opened = false

func _process(_delta):
	if opened: return
	if level.get_enemies_in_room() == 0:
		if anim.assigned_animation != "open":
			anim.play("open")
			opened = true
	else:
		if anim.assigned_animation != "close":
			anim.play("close")

func play_closing_sound():
	SoundPlayer.play("res://Music and Sounds/Oracle_Dungeon_Door.wav")

func play_opening_sound():
	SoundPlayer.play("res://Music and Sounds/Oracle_Dungeon_Door.wav")

func save():
	var save_dict = {
		"filename": get_filename(),
		"parent": get_parent().get_path(),
		"pos_x": position.x,
		"pos_y": position.y,
		"name": name,
		"opened": opened
	}
	return save_dict

func load_game(data):
	opened = data["opened"]
