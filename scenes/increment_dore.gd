extends TileMapLayer

@export var open_pos: Vector2
@export var close_pos: Vector2
@export var speed: float
@export var num_needed: int
var num_on: int = 0
var target_pos: Vector2

func _ready() -> void:
	target_pos = close_pos

func increment():
	num_on += 1
	print(num_on)
	if num_on >= num_needed:
		open()
func decrement():
	num_on -= 1
	print(num_on)
	if num_on < num_needed:
		close()

func open():
	print("open")
	target_pos = open_pos
func close():
	target_pos = close_pos
	
func _process(delta: float) -> void:
	position = lerp(position, target_pos, speed * delta)
