class_name Lever
extends Node2D
var toggled: bool = false
var target_rotation: float = 45
@onready var handle: Node2D = $Handle
signal on
signal off

func hit():
	toggled = !toggled
	if toggled:
		on.emit()
		target_rotation = -45
	else:
		off.emit()
		target_rotation = 45

func _process(delta: float) -> void:
	handle.rotation = lerp(handle.rotation, target_rotation, delta * 2)
