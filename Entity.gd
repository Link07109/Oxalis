extends Node2D

const Heart = preload("res://Pickups/Heart.tscn")
const Key = preload("res://Pickups/Key.tscn")

func instance_scene(scene):
	var new_scene = scene.instance()
	get_parent().get_parent().get_parent().call_deferred("add_child", new_scene)
	new_scene.global_position = global_position

func drop_item(item):
	if not item: return
	instance_scene(item)

func drop_item_rand(item):
	if not item: return
	var drop = randi() % 3
	if drop == 0:
		instance_scene(item)
