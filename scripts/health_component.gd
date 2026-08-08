class_name HealthComponent
extends Node

@export var max_hp: int = 10
@onready var hp: int = max_hp

signal died

# Returns remaining health
func take_damage(dmg: int) -> int:
	hp = max(0, hp - dmg)
	if hp == 0:
		died.emit()
	return hp

func heal(amount: int) -> int:
	hp = min(max_hp, hp + amount)
	return hp
