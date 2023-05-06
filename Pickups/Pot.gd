extends StaticBody2D

const PotEffect = preload("res://Effects/GrassEffect.tscn")

onready var sprite = $Sprite
onready var collision = $CollisionShape2D
onready var entity = $Entity

var destroyed = false

func create_pot_effect():
	entity.instance_scene(PotEffect)

func _on_Hurtbox_area_entered(_area):
	if destroyed: return
	entity.drop_item_rand(entity.Heart)
	create_pot_effect()
	destroyed = true
	queue_free()
	#sprite.frame = 1
	#collision.set_deferred("disabled", true)
