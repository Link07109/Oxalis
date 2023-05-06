extends Node2D

export(bool) var isSnow = false

const GrassEffect = preload("res://Effects/GrassEffect.tscn")
const SnowGrassEffect = preload("res://Effects/SnowGrassEffect.tscn")

func create_grass_effect():
	var grassEffect = GrassEffect.instance() if !isSnow else SnowGrassEffect.instance()
	get_parent().add_child(grassEffect)
	grassEffect.position = position

func _on_Hurtbox_area_entered(_area):
	create_grass_effect()
	queue_free()
