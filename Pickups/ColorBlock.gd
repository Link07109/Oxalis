extends StaticBody2D

export(bool) var up = true

onready var sprite = $Sprite
onready var area = $Area2D
onready var collision = $CollisionShape2D

var connected = false

func _ready():
	add_to_group("Persist")
	update_block()
	up = Transitions.block_blue_up

func _process(_delta):
	#if up and area.get_overlapping_bodies().size() > 0:
	#	collision.set_deferred("disabled", true)
	
	if connected: return
	# warning-ignore:return_value_discarded
	SignalBus.connect("sword_switch_activated", self, "activate")
	connected = true

func activate(_value):
	#SoundPlayer.play("res://Music and Sounds/EnemyDie.wav")
	up = !up
	update_block()

func _on_Area2D_body_exited(_body):
	if up:
		collision.set_deferred("disabled", false)

func save():
	var save_dict = {
		"filename": get_filename(),
		"parent": get_parent().get_path(),
		"pos_x": position.x,
		"pos_y": position.y,
		"up": up,
		"name": name,
	}
	return save_dict

func load_game(data):
	up = data["up"]
	update_block()

func update_block():
	if up:
		sprite.frame = 0
		collision.set_deferred("disabled", false)
	else:
		sprite.frame = 1
		collision.set_deferred("disabled", true)
