class_name HealthComponent
extends Node

@export var max_hp: int = 10
@export var hurt_sound: AudioStreamPlayer2D
@onready var hp: int = max_hp

signal died

# Returns remaining health
func take_damage(dmg: int) -> int:
	if hurt_sound != null:
		hurt_sound.play()
	hp = max(0, hp - dmg)
	if hp == 0:
		died.emit()
	return hp

func heal(amount: int) -> int:
	hp = min(max_hp, hp + amount)
	return hp
