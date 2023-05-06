extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

onready var entity = $Entity
onready var stats = $Stats
onready var hurtbox = $Hurtbox
onready var playerDetection = $PlayerDetectionZone
onready var wanderController = $WanderController
onready var blinkAnim = $BlinkAnim

var knockback = Vector2.ZERO

func create_death_effect():
	entity.instance_scene(EnemyDeathEffect)

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)

func _on_Hurtbox_area_entered(area):
	stats.hp -= area.damage
	knockback = area.knockback_vector * 120
	hurtbox.start_invincibility(0.5)
	hurtbox.create_hit_effect()
	SoundPlayer.play("res://Music and Sounds/Hurt.wav")

func _on_Stats_no_hp():
	entity.drop_item_rand(entity.Heart)
	create_death_effect()
	SoundPlayer.play("res://Music and Sounds/EnemyDie.wav")
	queue_free()

func _on_Hurtbox_invincibility_started():
	blinkAnim.play("Start")

func _on_Hurtbox_invincibility_ended():
	blinkAnim.play("Stop")

func save():
	var save_dict = {
		"filename": get_filename(),
		"parent": get_parent().get_path(),
		"pos_x": position.x,
		"pos_y": position.y,
		"name": name,
	}
	return save_dict

func load_game(_data):
	pass
