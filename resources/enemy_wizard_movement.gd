extends Node2D

@onready var parent = get_parent()

const SPEED: float = 120.0
const JUMP_VELOCITY: float = 225.0
var gravity = 125.0

@export_enum("Idle", "Chasing", "Backing Off") var state: int = 0
@export var player: Player = null
@export var sprite: AnimatedSprite2D

func idle(_delta: float) -> void:
	pass

func chase(_delta: float) -> void:
	var target_pos: Vector2 = player.get_global_position()
	
	if not parent.is_on_floor():
		parent.velocity.y += gravity * _delta
	else:
		parent.velocity.y = 225
		
	
	
	if get_global_position().x > target_pos.x:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
		
	var direction = global_position.direction_to(target_pos)
	if direction:
		if parent.is_on_floor():
			parent.velocity.x = direction.x * SPEED
			# velocity.z = direction.z * SPEED
		else:
			parent.velocity.x = lerp(parent.velocity.x, direction.x * SPEED, 0.01)
			# velocity.z = lerp(velocity.z, direction.z * SPEED, 0.001)
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, SPEED)

	
func back_off(_delta: float) -> void:
	var target_pos: Vector2 = player.get_global_position()



func choose_state(_delta: float) -> void:
	match state:
		0:
			idle(_delta)
		1:
			chase(_delta)
		2: 
			back_off(_delta)



func do_movement(_delta: float) -> void:
	if parent.firing_component == null:
		state = 0
		idle(_delta)
		return


	player = parent.firing_component.player
	if player != null:
		if $StateTimer.is_stopped():
			state = 1
			$StateTimer.start()
		choose_state(_delta)
	else: # No player, idle
		state = 0
		idle(_delta)


func _on_state_timer_timeout() -> void:
	if state == 0:
		return
	state = 1 if state == 2 else 2
	$StateTimer.start()
