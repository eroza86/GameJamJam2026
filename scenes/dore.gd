extends TileMapLayer

@export var open_pos: Vector2
@export var close_pos: Vector2
@export var speed: float
var target_pos: Vector2

func _ready() -> void:
	target_pos = close_pos

func open():
	target_pos = open_pos
func close():
	target_pos = close_pos
	
func _process(delta: float) -> void:
	position = lerp(position, target_pos, speed * delta)
