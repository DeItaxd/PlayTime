extends CSGBox3D

func _ready():
	Signals.connect("voided", voided)
	visible = false
	use_collision = false

func voided():
	if use_collision == false:
		use_collision = true
	else:
		use_collision = false
