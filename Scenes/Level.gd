extends Node2D

func _ready():
	# warning-ignore:return_value_discarded
	SignalBus.connect("save_game", self, "save_room")
	
	randomize()
	SoundPlayer.stop_all()
	if name.begins_with("Dungeon"):
		MusicPlayer.play_music("res://Music and Sounds/xDeviruchi - Prepare for Battle! .wav")
	elif name.begins_with("Forest"):
		MusicPlayer.play_music("res://Music and Sounds/Steel Thy Shovel.wav")
	elif name.begins_with("Snowy"):
		if name == "Snowy5":
			MusicPlayer.play_music("res://Music and Sounds/graveyard.wav")
		else:
			MusicPlayer.play_music("res://Music and Sounds/Snowy.wav")
	
	load_room()
	
	var spawn = find_node(Transitions.door_name)
	var player = find_node("Player")
	if spawn:
		player.position.x = spawn.position.x
		player.position.y = spawn.position.y
	
	# Player facing direction
	player.animTree.set("parameters/AnimationNodeStateMachine/Run/blend_position", Transitions.blend)
	player.animTree.set("parameters/AnimationNodeStateMachine/Idle/blend_position", Transitions.blend)
	player.animTree.set("parameters/AnimationNodeStateMachine/Attack/blend_position", Transitions.blend)
	
	#yield(Transitions, "transition_completed")
	get_tree().paused = false
	player.can_move = true

func get_enemies_in_room():
	var enemyNode = get_node("YSort/Enemies")
	if enemyNode:
		return enemyNode.get_child_count()
	return 0

func save_room():
	var save_game = File.new()
	save_game.open("user://" + name + ".save", File.WRITE)
	
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	
	for i in save_nodes:
		var node_data = i.call("save")
		save_game.store_line(to_json(node_data))
	
	save_game.close()

func load_room():
	var save_game = File.new()
	if not save_game.file_exists("user://" + name + ".save"):
		return
	
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		i.queue_free()
	
	save_game.open("user://" + name + ".save", File.READ)
	
	while save_game.get_position() < save_game.get_len():
		var cur_line = parse_json(save_game.get_line())
		if not cur_line:
			continue
		
		var new_obj = load(cur_line["filename"]).instance()
		get_node(cur_line["parent"]).add_child(new_obj)
		new_obj.position = Vector2(cur_line["pos_x"], cur_line["pos_y"])
		new_obj.name = cur_line["name"]
		new_obj.add_to_group("Persist")
		
		new_obj.load_game(cur_line)
	
	save_game.close()
