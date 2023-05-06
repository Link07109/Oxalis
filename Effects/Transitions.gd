extends CanvasLayer

var door_name = ""
var blend
var block_blue_up = true

onready var animationPlayer = $AnimationPlayer

signal transition_completed

func _ready():
	# warning-ignore:return_value_discarded
	SignalBus.connect("sword_switch_activated", self, "change_block_var")

func change_block_var(value):
	block_blue_up = true if value == 1 else false

func play_enter_transition():
	animationPlayer.play("EnterLevel")
	
func play_exit_transition():
	animationPlayer.play("ExitLevel")

func _on_AnimationPlayer_animation_finished(_anim_name):
	emit_signal("transition_completed")
