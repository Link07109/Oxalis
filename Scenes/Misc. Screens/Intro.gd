extends Control

onready var dialogue = $DialogueBox
onready var door = $Node/Door

func _ready():
	MusicPlayer.stop_all()
	dialogue.start()

func _input(event):
	if dialogue.active == false:
		if event.is_action_pressed("ui_cancel"):
			door.go_to_room()

func save_room():
	pass
