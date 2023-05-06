extends Node

export(int) var keys = 0 setget set_keys
export(int) var max_hp = 1 setget set_max_hp
var hp = max_hp setget set_hp

signal keys_changed(value)
signal no_hp
signal hp_changed(value)
signal max_hp_changed(value)

func set_keys(value):
	keys = max(0, value)
	emit_signal("keys_changed", keys)

func set_max_hp(value):
	max_hp = max(value, 1)
	self.hp = min(hp, max_hp)
	emit_signal("max_hp_changed", max_hp)

func set_hp(value):
	hp = clamp(value, 0, max_hp)
	emit_signal("hp_changed", hp)
	if hp <= 0:
		emit_signal("no_hp")

func _ready():
	if name == "PlayerStats":
		# warning-ignore:return_value_discarded
		SignalBus.connect("deleted_saves", self, "reset_default")
		load_game()
	else:
		self.hp = max_hp

func reset_default():
		max_hp = 4
		self.hp = max_hp
		self.keys = 0

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		print("bye !")
		
		if name == "PlayerStats":
			save()
			SignalBus.emit_signal("save_game")

func save():
	var save_game = File.new()
	save_game.open("user://" + name + ".save", File.WRITE)
	
	var data = {
		"filename": get_filename(),
		"hp": hp,
		"max_hp": max_hp,
		"keys": keys
	}
	save_game.store_line(to_json(data))
	
	save_game.close()

func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://" + name + ".save"):
		self.hp = max_hp
		return
	
	save_game.open("user://" + name + ".save", File.READ)
	
	while save_game.get_position() < save_game.get_len():
		var cur_line = parse_json(save_game.get_line())
		if not cur_line:
			continue
		
		max_hp = cur_line["max_hp"]
		self.hp = cur_line["hp"]
		self.keys = cur_line["keys"]
	
	save_game.close()
