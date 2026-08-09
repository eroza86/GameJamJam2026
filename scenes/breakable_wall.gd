class_name BreakableWall
extends TileMapLayer
@export var health: int = 1

func damage(amount: int):
	health -= amount
	if health <- 0:
		queue_free()
