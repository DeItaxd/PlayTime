extends CSGBox3D

func _ready():
	Signals.connect("voided", voided)
	visible = true
	use_collision = false

func voided():
	if visible:
		visible = false
	else:
		visible = true
