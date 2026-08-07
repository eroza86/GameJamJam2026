extends Camera2D
@export var target: Node2D
@export var SPEED: float

func _process(delta: float) -> void:
	var distance = position.distance_to(target.position)
	position = position.move_toward(target.position, SPEED * distance * delta)
