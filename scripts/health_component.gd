class_name HealthComponent
extends Node

@export var max_hp: int = 10
@onready var hp: int = max_hp

signal died

# Returns remaining health
func take_damage(dmg: int) -> int:
	print(hp)
	print(dmg)
	hp = max(0, hp - dmg)
	if hp == 0:
		died.emit()
	return hp
