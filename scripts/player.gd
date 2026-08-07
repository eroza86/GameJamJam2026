extends CharacterBody2D
@export var SPEED = 1.0
@export var ACCELERATION = 1.0
@export var FRICTION = 1.0

@export var GRAVITY = 1.0
@export var FALL_GRAVITY = 1.0
@export var FAST_FALL_GRAVITY = 1.0

@export var JUMP_VELOCITY = 1.0

@export var INPUT_BUFFER_WINDOW = 1.0
@export var COYOTE_WINDOW = 1.0

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
	elif jump_attempted:
		input_buffer.start()
		
	# handle fast fall on jump release
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = JUMP_VELOCITY / 4
	
	if is_on_floor():
		coyote_jump_available = true
		coyote_timer.stop()
	else:
		if coyote_jump_available:
			if coyote_timer.is_stopped():
				coyote_timer.start()
		velocity.y += get_gravity_type(horizontal_input) * delta
		
	var floor_damping : float = 1.0 if is_on_floor() else 0.2
	var dash_multiplier : float = 2.0 if Input.is_action_pressed("dash") else 1.0
	if horizontal_input:
		velocity.x = move_toward(velocity.x, horizontal_input * SPEED * dash_multiplier, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta * floor_damping)
		
	move_and_slide()

func coyote_timeout():
	coyote_jump_available = false
	
func get_gravity_type(input_direction : float = 0) -> float:
	if Input.is_action_pressed("down"):
		return FAST_FALL_GRAVITY
	if velocity.y < 0:
		return GRAVITY
	return FALL_GRAVITY
