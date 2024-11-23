extends Node3D

var health = 3
var dead = false

@onready var anim = $AnimationPlayer
@onready var timer = $Timer

func _on_area_3d_body_part_hit(dam):
	if !dead:
		health -= dam
		if health <= 0:
			dead = true
			anim.play("Die")
			timer.start(3.0)

func _on_timer_timeout():
	anim.play("Revive")
	dead = false
