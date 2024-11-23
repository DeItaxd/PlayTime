extends StaticBody2D

@onready var collision = $CollisionPolygon2D
@onready var collision2 = $CollisionPolygon2D2

func _ready():
	collision.disabled = false
	collision2.disabled = false
	Signals.connect("forward", forward)
	Signals.connect("backward", backward)
	visible = true

func forward():
	visible = false
	collision.disabled = true
	collision2.disabled = true

func backward():
	visible = true
	collision.disabled = false
	collision2.disabled = false
