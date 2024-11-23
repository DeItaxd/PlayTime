extends StaticBody2D

@onready var polygon2d = $Polygon2D
@onready var collision = $CollisionPolygon2D

func _ready():
	collision.polygon = polygon2d.polygon
