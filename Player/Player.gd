extends KinematicBody2D

export var ACCEL = 10000
export var MAX_SPEED = 70
export var FRICTION = 10000

enum {
	MOVE,
	ATTACK
}

var state = MOVE
var can_move = false
var velocity = Vector2.ZERO
var stats = PlayerStats

onready var anim = $AnimationPlayer
onready var blinkAnim = $BlinkAnimation
onready var animTree = $AnimationTree
onready var animState = animTree.get("parameters/AnimationNodeStateMachine/playback")

onready var swordHitbox = $HitboxPivot/SwordHitbox
onready var hurtbox = $Hurtbox

onready var door = $GoToDeathScreen

func _ready():
	stats.connect("no_hp", self, "death")
	animTree.active = true
	swordHitbox.knockback_vector = Vector2.DOWN

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	match state:
		MOVE:
			if can_move:
				move_state(input_vector, delta)
			else:
				animState.travel("Idle")
		ATTACK:
			attack_state(delta)

func move_state(input_vector, delta):
	if input_vector != Vector2.ZERO:
		swordHitbox.knockback_vector = input_vector
		
		animTree.set("parameters/AnimationNodeStateMachine/Run/blend_position", input_vector)
		animTree.set("parameters/AnimationNodeStateMachine/Idle/blend_position", input_vector)
		animTree.set("parameters/AnimationNodeStateMachine/Attack/blend_position", input_vector)
		
		animState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCEL * delta)
	else:
		animState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func attack_state(_delta):
	animState.travel("Attack")
	velocity = Vector2.ZERO

func play_attack_sound():
	SoundPlayer.play("res://Music and Sounds/Swipe.wav")

func attack_animation_finished():
	state = MOVE

func _on_Hurtbox_area_entered(area):
	stats.hp -= area.damage
	hurtbox.start_invincibility(0.8)
	hurtbox.create_hit_effect()
	SoundPlayer.play("res://Music and Sounds/Hurt.wav")

func death():
	SoundPlayer.stop_all()
	can_move = false
	door.go_to_room()

func _on_Hurtbox_invincibility_started():
	blinkAnim.play("Start")

func _on_Hurtbox_invincibility_ended():
	blinkAnim.play("Stop")
