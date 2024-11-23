extends CharacterBody2D

@export var speed = 500
@export var gravity = 30
@export var jump_force = -800.0
@export var wall_jump_pushback = 2000
@export var wall_slide_gravity = 10
@export var dash_speed = 1500
@export var melee_lunge = 900
@export var attacking = false
@export var max_air_attacks = 3
var air_attack_count = 0
var attack_locked = false
var can_attack = true
var is_wall_sliding = false
var dashing = false
var can_dash = true
var dash_locked = false
var in_future = false
var can_timeswitch = true

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	else:
		dash_locked = false
		attack_locked = false
		air_attack_count = 0
	
	if is_on_wall():
		attack_locked = false
		air_attack_count = 0
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("fast_fall") - Input.get_action_strength("jump")
	input_vector = input_vector.normalized()
	var horizontal_direction = Input.get_axis("left", "right")
	if dashing:
		velocity = dash_speed * input_vector
	elif !attacking:
		velocity.x = speed * horizontal_direction
	
	jump()
	climb()
	dash()
	move_and_slide()
	wall_slide(delta)
	melee()
	timeswitch()
	
	if is_on_floor():
		var floor_normal: Vector2 = get_floor_normal()
		$Texture.rotation = floor_normal.angle()
	elif is_on_wall():
		var wall_normal: Vector2 = get_wall_normal()
		$Texture.rotation = wall_normal.angle()
	else:
		$Texture.rotation = 0 
		

func jump():
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_force

func dash():
	if !is_on_floor():
		if Input.is_action_just_pressed("dash") and can_dash and !dash_locked:
			dashing = true
			can_dash = false
			dash_locked = true
			$DashTimer.start()
			$DashCD.start()
	else:
		if Input.is_action_just_pressed("dash") and can_dash and !dash_locked:
			dashing = true
			can_dash = false
			$DashTimer.start()
			$DashCD.start()

func climb():
	if is_on_wall() and Input.is_action_pressed("jump") and (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		velocity.y += jump_force / 2
		if velocity.y < -600:
			velocity.y = -600

func wall_slide(delta):
	if is_on_wall() and !is_on_floor():
		if (Input.is_action_pressed("left") or Input.is_action_pressed("right")) and Input.is_action_pressed("fast_fall"):
			is_wall_sliding = false
		elif Input.is_action_pressed("left") or Input.is_action_pressed("right"): 
			is_wall_sliding = true
		else: 
			is_wall_sliding = false
		
		if is_wall_sliding:
			velocity.y += (wall_slide_gravity * delta)
			velocity.y = min(velocity.y, wall_slide_gravity)

func melee():
	if Input.is_action_just_pressed("hit") and !attack_locked and can_attack:
		$MeleeAnim.play("Hit")
		can_attack = false
		$MeleeCD.start()
		
		if !is_on_floor():
			air_attack_count += 1
			if air_attack_count >= max_air_attacks:
				attack_locked = true
		
		var mouse_position = get_global_mouse_position()
		var direction = (mouse_position - global_position).normalized()
		
		velocity = direction * melee_lunge

func timeswitch():
	if Input.is_action_just_pressed("timeswitch") and can_timeswitch and !in_future:
		can_timeswitch = false
		in_future = true
		Signals.forward.emit()
		$Timeswitch.start()

func _on_dash_timer_timeout():
	dashing = false

func _on_dash_cd_timeout():
	can_dash = true

func _on_melee_cd_timeout():
	can_attack = true

func _on_timeswitch_timeout():
	$TimeswitchCD.start()
	in_future = false
	Signals.backward.emit()

func _on_timeswitch_cd_timeout():
	can_timeswitch = true
