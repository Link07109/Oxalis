extends StaticBody2D

export(String, FILE, "*.tscn") var item = ""

onready var sprite = $Sprite

func _on_Area2D_body_entered(_body):
	if not sprite.frame == 0: return
	sprite.frame = 1
	SoundPlayer.play("res://Music and Sounds/Oracle_Chest.wav")
	print(str("There was an ", item, " in the chest!"))
