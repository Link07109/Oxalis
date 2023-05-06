extends Control

func _ready():
	MusicPlayer.play_music("res://Music and Sounds/xDeviruchi - Title Theme .wav")

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$Node/Level1.go_to_room()
	if event.is_action_pressed("ui_accept"):
		delete_saves()

func delete_saves():
	var dir = Directory.new()
	
	if dir.open("user://") == OK:
		dir.list_dir_begin()
		
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				dir.remove(file_name)
				print("Deleted file: " + file_name)
			file_name = dir.get_next()
		SignalBus.emit_signal("deleted_saves")
	else:
		print("An error occurred trying to access saves path.")


func save_room():
	pass
