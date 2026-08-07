extends Camera2D
@export var target: Node2D
@export var SPEED: float

func _physics_process(delta: float) -> void:
	if target != null:
		global_position = global_position.lerp(target.position, SPEED * delta)
