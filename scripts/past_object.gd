extends StaticBody2D

@onready var polygon2d = $Polygon2D
@onready var collision = $CollisionPolygon2D

func _ready():
	collision.polygon = polygon2d.polygon
	collision.disabled = false
	Signals.connect("forward", forward)
	Signals.connect("backward", backward)
	visible = true

func forward():
	visible = false
	collision.disabled = true

func backward():
	visible = true
	collision.disabled = false
