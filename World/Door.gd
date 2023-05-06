extends Area2D

export(String, FILE, "*.tscn") var target_level_path = ""

func go_to_room():
	if get_parent().name != "Player":
		SignalBus.emit_signal("save_game") # save current room before switchingSS
	Transitions.play_exit_transition()
	get_tree().paused = true
	yield(Transitions, "transition_completed")
	Transitions.play_enter_transition()
	Transitions.door_name = name
	# warning-ignore:return_value_discarded
	get_tree().change_scene(target_level_path)

func _on_Door_body_entered(body):
	if not body.name == "Player": return
	if target_level_path.empty(): return
	body.can_move = false
	Transitions.blend = body.animTree.get("parameters/AnimationNodeStateMachine/Idle/blend_position")
	go_to_room()
