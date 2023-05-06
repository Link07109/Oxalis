extends "res://Pickups/Pickup.gd"

func body_entered(body):
	if body.name == "Player":
		PlayerStats.keys += 1
		queue_free()
