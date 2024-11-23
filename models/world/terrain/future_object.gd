extends MeshInstance3D

@onready var collision = $Static/CollisionShape3D

func _ready():
	Signals.connect("timeshift", timeshift)
	visible = false
	collision.disabled = true

func timeshift():
	if !visible:
		visible = true
		collision.disabled = false
	else:
		visible = false
		collision.disabled = true
