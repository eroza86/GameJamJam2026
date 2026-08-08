extends Node2D

@onready var parent = get_parent()

const SPEED: float = 120.0

func do_movement() -> void:
	if parent.firing_component != null and parent.firing_component.player != null:
		var player = parent.firing_component.player

	
		var target_pos: Vector2 = player.get_global_position()

		# SPEED *= 1.1 * time
	
		var direction = global_position.direction_to(target_pos)
		if direction:
			if parent.is_on_floor():
				parent.velocity.x = direction.x * SPEED
				parent.velocity.y = direction.y * SPEED
			else:
				parent.velocity.x = lerp(parent.velocity.x, direction.x * SPEED, 0.01)
				parent.velocity.y = lerp(parent.velocity.y, direction.y * SPEED, 0.01)
		else:
			parent.velocity.x = move_toward(parent.velocity.x, 0, SPEED)
