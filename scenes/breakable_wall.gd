class_name BreakableWall
extends TileMapLayer
@export var health: int = 1
signal broken

func damage(amount: int):
	health -= amount
	if health <- 0:
		broken.emit()
		queue_free()
