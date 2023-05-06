extends CanvasLayer

export(String, FILE, "*.json") var d_file

var dialogue = []
var cur_dialogue_index = -1
var active = false

onready var text_box = $NinePatchRect
onready var dialogue_text = $NinePatchRect/Text
onready var timer = $Timer

onready var player = get_parent().get_parent().find_node("Player")

func _ready():
	text_box.visible = false
	dialogue_text.set_visible_characters(0)

func start():
	if active:
		return
	active = true
	text_box.visible = true
	
	dialogue = load_dialogue()
	
	if player:
		player.set("can_move", false)
	next_line()

func load_dialogue():
	var file = File.new()
	if file.file_exists(d_file):
		file.open(d_file, file.READ)
		return parse_json(file.get_as_text())

func _input(event):
	if not active:
		return
	
	if event.is_action_pressed("ui_cancel"):
		if dialogue_text.get_visible_characters() >= dialogue_text.get_total_character_count():
			next_line()
		else:
			dialogue_text.set_visible_characters(dialogue_text.get_total_character_count())
			timer.stop()
			SoundPlayer.stop_solo()

func next_line():
	dialogue_text.set_visible_characters(0)
	timer.start()
	cur_dialogue_index += 1
	
	if cur_dialogue_index >= len(dialogue):
		active = false
		text_box.visible = false
		timer.stop()
		SoundPlayer.stop_solo()
		if player:
			player.set("can_move", true)
		cur_dialogue_index = -2
		return
	
	$NinePatchRect/Name.text = dialogue[cur_dialogue_index]["name"]
	dialogue_text.text = dialogue[cur_dialogue_index]["text"]

func _on_Timer_timeout():
	dialogue_text.set_visible_characters(dialogue_text.get_visible_characters() + 1)
	
	if dialogue_text.get_visible_characters() >= dialogue_text.get_total_character_count():
		timer.stop()
		SoundPlayer.stop_solo()
	else:
		pass#SoundPlayer.play_solo("res://Music and Sounds/typing.wav")
