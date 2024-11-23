extends CSGBox3D

func _ready():
	Signals.connect("voided", voided)
	visible = false
	use_collision = true

func voided():
	if use_collision:
		use_collision = false
	else:
		use_collision = true
