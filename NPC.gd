extends Node2D

onready var dialogue = $DialogueBox
onready var area2D = $Area2D

func _input(event):
	if not len(area2D.get_overlapping_bodies()) > 0: return
	if event.is_action_pressed("ui_cancel"):
		say_dialogue()

func say_dialogue():
	if dialogue.cur_dialogue_index == -2:
		dialogue.cur_dialogue_index += 1
		return
	dialogue.start()
