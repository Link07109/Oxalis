extends ParallaxLayer

func _process(delta):
	motion_offset.x -= 7 * delta
	motion_offset.y -= 7 * delta
