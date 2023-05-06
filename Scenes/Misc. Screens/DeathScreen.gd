extends Control

func _ready():
	MusicPlayer.play_music("res://Music and Sounds/Death Screen.wav")
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		PlayerStats.hp = PlayerStats.max_hp
		$Node/Door.go_to_room()

func save_room():
	pass
