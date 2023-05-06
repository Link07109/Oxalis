extends "res://Pickups/SmallChest.gd"

onready var level = get_parent().get_parent().get_parent()
onready var areaCollision = $Area2D/CollisionShape2D
onready var collision = $CollisionShape2D

var shown = false

func _ready():
	update_chest(false)

func _process(_delta):
	if shown: return
	if level.get_enemies_in_room() == 0:
		update_chest(true)
		shown = true
		SoundPlayer.play("res://Music and Sounds/Oracle_Secret.wav")
	else:
		update_chest(false)

func update_chest(vis):
	sprite.visible = vis
	areaCollision.disabled = !vis
	collision.disabled = !vis

func save():
	var save_dict = {
		"filename": get_filename(),
		"parent": get_parent().get_path(),
		"pos_x": position.x,
		"pos_y": position.y,
		"name": name,
		"activated": shown,
		"opened": sprite.frame == 1
	}
	return save_dict

func load_game(data):
	sprite.frame = 1 if data["opened"] else 0
	shown = data["activated"]
	
	if shown:
		update_chest(true)
