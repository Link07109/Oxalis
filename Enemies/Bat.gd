extends "res://Enemies/Enemy.gd"

enum {
	IDLE,
	WANDER,
	CHASE
}

const ACCELERATION = 300
const MAX_SPEED = 45
const FRICTION = 5000

var velocity = Vector2.ZERO
var state = IDLE

onready var sprite = $AnimatedSprite

func _ready():
	state = pick_random_state([IDLE, WANDER])

func _physics_process(delta):
	match state:
		IDLE:
			idle_state()
		WANDER:
			wander_state(delta)
		CHASE:
			chase_state(delta)
	
	velocity = move_and_slide(velocity)

func idle_state():
	seek_player()
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
	
	if wanderController.get_time_left() == 0:
		update_wander()

func wander_state(delta):
	seek_player()
	
	if wanderController.get_time_left() == 0:
		update_wander()
	
	accel_to_point(wanderController.target_position, delta)
	
	if global_position.distance_squared_to(wanderController.target_position) <= 4:
		update_wander()

func chase_state(delta):
	var player = playerDetection.player
	if player:
		accel_to_point(player.global_position, delta)
	else:
		state = IDLE

func seek_player():
	if playerDetection.can_see_player():
		state = CHASE

func accel_to_point(point, delta):
	var dir = global_position.direction_to(point)
	velocity = velocity.move_toward(dir * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0

func pick_random_state(states):
	return randi() % states.size()

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.set_wander_timer(rand_range(0.5, 1.5))
