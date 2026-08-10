class_name HealthComponent
extends Node

@export var max_hp: int = 10
@export var hurt_sound: AudioStreamPlayer2D
@export var health_bar: ProgressBar
@onready var hp: int = max_hp

signal died

func _ready() -> void:
	if health_bar != null:
		health_bar.max_value = max_hp
		health_bar.value = hp

# Returns remaining health
func take_damage(dmg: int) -> int:
	if hurt_sound != null:
		hurt_sound.play()
	hp = max(0, hp - dmg)
	if hp == 0:
		died.emit()
	
	if health_bar != null:
		health_bar.value = hp
	return hp

func heal(amount: int) -> int:
	hp = min(max_hp, hp + amount)
	if health_bar != null:
		health_bar.value = hp
	return hp
