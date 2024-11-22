extends CharacterBody2D

@export var speed = 500
@export var gravity = 30
@export var jump_force = 800

func _physics_process(_delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -jump_force
	
	var horizontal_direction = Input.get_axis("left", "right")
	
	velocity.x = speed * horizontal_direction
	
	move_and_slide()
	
	if is_on_floor():
		var floor_normal: Vector2 = get_floor_normal()
		$Sprite2D.rotation = floor_normal.angle()
	else:
		$Sprite2D.rotation = 0 
