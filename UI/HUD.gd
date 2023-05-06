extends Control

var max_hearts = 4 setget set_max_hearts
var hearts = 4 setget set_hearts
var keys = 0 setget set_keys

var heart_sprite_width = 11

var stats = PlayerStats

onready var heartUIEmpty = $HeartUIEmpty
onready var heartUIFull = $HeartUIFull
onready var keyCount = $KeyCount

func set_keys(value):
	keys = value
	if keyCount != null:
		keyCount.text = String(keys)

func set_max_hearts(value):
	max_hearts = value
	if heartUIEmpty != null:
		heartUIEmpty.rect_size.x = max_hearts * heart_sprite_width

func set_hearts(value):
	hearts = value
	if heartUIFull != null:
		heartUIFull.rect_size.x = hearts * heart_sprite_width
	
func _ready():
	self.max_hearts = stats.max_hp
	self.hearts = stats.hp
	self.keys = stats.keys
	stats.connect("max_hp_changed", self, "set_max_hearts")
	stats.connect("hp_changed", self, "set_hearts")
	stats.connect("keys_changed", self, "set_keys")
