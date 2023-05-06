extends Sprite

export(bool) var isFloorSwitch = true
var activated = false

signal activated

func _ready():
	add_to_group("Persist")
	if !isFloorSwitch:
		add_to_group("SwordSwitch")
		# warning-ignore:return_value_discarded
		SignalBus.connect("sword_switch_activated", self, "on_sword_hit")

func on_sword_hit(frame):
	var nodes = get_tree().get_nodes_in_group("SwordSwitch")
	for node in nodes:
		node.frame = frame
	SoundPlayer.play("res://Music and Sounds/OOT_CrystalSwitch.wav")

# Sword hits switch
func _on_Switch_area_entered(_area):
	if isFloorSwitch: return
	if not activated:
		activated = true
		SignalBus.emit_signal("sword_switch_activated", 1)
	else:
		activated = false
		SignalBus.emit_signal("sword_switch_activated", 0)

# Player steps on switch
func _on_Switch_body_entered(_body):
	if not isFloorSwitch: return
	if not activated:
		activated = true
		emit_signal("activated")
		frame = 1
		SoundPlayer.play("res://Music and Sounds/EnemyDie.wav")

func save():
	var save_dict = {
		"filename": get_filename(),
		"parent": get_parent().get_path(),
		"pos_x": position.x,
		"pos_y": position.y,
		"activated": activated,
		"name": name
	}
	return save_dict

func load_game(data):
	activated = data["activated"]
	
	if activated:
		emit_signal("activated")
		frame = 1
