extends Area2D

func _ready():
	# warning-ignore:return_value_discarded
	connect("body_entered", self, "body_entered")
	# warning-ignore:return_value_discarded
	connect("area_entered", self, "area_entered")

func body_entered(_body):
	pass

func area_entered(area):
	# SwordHitbox
	body_entered(area.get_parent().get_parent())
