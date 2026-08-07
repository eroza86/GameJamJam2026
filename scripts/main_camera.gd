extends Camera2D
@export var target: Node2D
@export var SPEED: float

func _physics_process(delta: float) -> void:
	if target != null:
		var distance = position.distance_to(target.position)
		position = position.move_toward(target.position, SPEED * distance * delta)
