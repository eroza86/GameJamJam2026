class_name BreakableWall
extends StaticBody2D
@export var health: int = 1

func damage(amount: int):
	health -= amount
	if health <- 0:
		queue_free()
