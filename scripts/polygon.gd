extends StaticBody2D

@onready var polygon2d = $Polygon2D
@onready var collision = $CollisionPolygon2D

func _ready():
	collision.polygon = polygon2d.polygon
	collision.disabled = true
	Signals.connect("forward", forward)
	Signals.connect("backward", backward)
	visible = false

func forward():
	visible = true
	collision.disabled = false

func backward():
	visible = false
	collision.disabled = true