extends MeshInstance3D

@onready var collision = $Static/CollisionShape3D

func _ready():
	Signals.connect("timeshift", timeshift)
	visible = true
	collision.disabled = false

func timeshift():
	if visible:
		visible = false
		collision.disabled = true
	else:
		visible = true
		collision.disabled = false
