extends CSGBox3D

func _ready():
	Signals.connect("voided", voided)
	visible = false
	use_collision = false

func voided():
	if !visible:
		visible = true
	else:
		visible = false
