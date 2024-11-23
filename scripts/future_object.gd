extends StaticBody2D

@onready var collision = $CollisionPolygon2D
@onready var collision2 = $CollisionPolygon2D2

func _ready():
	collision.disabled = true
	collision2.disabled = true
	Signals.connect("forward", forward)
	Signals.connect("backward", backward)
	visible = false

func forward():
	visible = true
	collision.disabled = false
	collision2.disabled = false

func backward():
	visible = false
	collision.disabled = true
	collision2.disabled = true