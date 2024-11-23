extends StaticBody3D

@onready var collision = $CollisionShape3D

func _ready():
	Signals.connect("voided", voided)
	visible = true
	collision.disabled = false

func voided():
	if visible:
		visible = false
		collision.disabled = true
	else:
		visible = true
		collision.disabled = false
