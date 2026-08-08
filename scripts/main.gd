extends Node

@export var menu_scene: PackedScene
@export var stage_scene: PackedScene
@export var refill_scene: PackedScene

func _on_play_pressed() -> void:
	$Menu.queue_free()
	var refill = refill_scene.instantiate()
	add_child(refill)


func _on_debug_play_pressed() -> void:
	$Menu.queue_free()
	var stage = stage_scene.instantiate()
	add_child(stage)
