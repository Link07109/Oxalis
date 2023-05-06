extends StaticBody2D

onready var area = $Area2D
onready var anim = $AnimationPlayer
onready var sprite = $Sprite

func _ready():
	area.connect("body_entered", self, "body_entered")

func body_entered(body):
	if body.name == "Player":
		if PlayerStats.keys > 0:
			PlayerStats.keys -= 1
			anim.play("open")

func play_opening_sound():
	SoundPlayer.play("res://Music and Sounds/Oracle_Chest.wav")

func save():
	var save_dict = {
		"filename": get_filename(),
		"parent": get_parent().get_path(),
		"pos_x": position.x,
		"pos_y": position.y,
		"rotation_degrees": rotation_degrees,
		"name": name,
	}
	return save_dict

func load_game(data):
	rotation_degrees = data["rotation_degrees"]
