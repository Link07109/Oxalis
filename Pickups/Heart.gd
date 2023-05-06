extends "res://Pickups/Pickup.gd"

func body_entered(body):
	if body.name == "Player":
		PlayerStats.hp += 1
		SoundPlayer.play("res://Music and Sounds/Oracle_Get_Heart.wav")
		queue_free()
