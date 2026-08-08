class_name Player
extends CharacterBody2D
@export var SPEED = 135.0
@export var ACCELERATION = 1200.0
@export var FRICTION = 1400.0

@export var GRAVITY = 500.0
@export var FALL_GRAVITY = 1000.0
@export var FAST_FALL_GRAVITY = 1500.0
@export var MAX_FALL_SPEED = 200.0
@export var MAX_FAST_FALL_SPEED = 300.0
@export var MAX_HORI_SPEED = 500.0

@export var JUMP_VELOCITY = -200.0

@export var INPUT_BUFFER_WINDOW = 0.1
@export var COYOTE_WINDOW = 0.08

var input_buffer : Timer
var coyote_timer : Timer
var coyote_jump_available :=  true

func _ready() -> void:
	# setup input buffer timer
	input_buffer = Timer.new()
	input_buffer.wait_time = INPUT_BUFFER_WINDOW
	input_buffer.one_shot = true
	add_child(input_buffer)
	
	# setup coyote timer
	coyote_timer = Timer.new()
	coyote_timer.wait_time = COYOTE_WINDOW
	coyote_timer.one_shot = true
	add_child(coyote_timer)
	coyote_timer.timeout.connect(coyote_timeout)
	
func _physics_process(delta: float) -> void:
	var horizontal_input = Input.get_axis("move_left", "move_right")
	var jump_attempted = Input.is_action_just_pressed("jump")
	
	# handle jumping
	if jump_attempted or input_buffer.time_left > 0:
		if coyote_jump_available:
			velocity.y = JUMP_VELOCITY
			coyote_jump_available = false
			if input_buffer.time_left > 0 and !Input.is_action_pressed("jump"):
				velocity.y = JUMP_VELOCITY / 4
		elif jump_attempted:
			input_buffer.start()
		
	# handle fast fall on jump release
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = velocity.y / 4
	
	if is_on_floor():
		coyote_jump_available = true
		coyote_timer.stop()
	else:
		if coyote_jump_available:
			if coyote_timer.is_stopped():
				coyote_timer.start()
		velocity.y += get_gravity_type(horizontal_input) * delta
		
	var floor_damping : float = 1.0 if is_on_floor() else 0.1
	var dash_multiplier : float = 1.25 if Input.is_action_pressed("dash") else 1.0
	if horizontal_input:
		velocity.x = move_toward(velocity.x, horizontal_input * SPEED * dash_multiplier, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta * floor_damping)
	
	if Input.is_action_pressed("down") and velocity.y > 0:
		if velocity.y > MAX_FAST_FALL_SPEED:
			velocity.y = MAX_FAST_FALL_SPEED
	else:
		if velocity.y > MAX_FALL_SPEED:
			velocity.y = MAX_FALL_SPEED
	
	if abs(velocity.x) > MAX_HORI_SPEED:
		velocity.x = sign(velocity.x) * MAX_HORI_SPEED
	
	move_and_slide()

func coyote_timeout():
	coyote_jump_available = false
	
func get_gravity_type(input_direction : float = 0) -> float:
	if Input.is_action_pressed("down"):
		return FAST_FALL_GRAVITY
	if velocity.y < 0:
		return GRAVITY
	return FALL_GRAVITY
