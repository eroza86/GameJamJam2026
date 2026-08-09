extends Node

@export var menu_scene: PackedScene
@export var stage_scene: PackedScene
@export var refill_scene: PackedScene

func _on_play_pressed() -> void:
	$Menu.queue_free()
	var refill = refill_scene.instantiate()
	add_child(refill)
	refill.connect("start_play_with", start_game)

func start_game(shells: Array[Shell]) -> void:
	var stage = stage_scene.instantiate()
	add_child(stage)
	if shells != null and shells.size() > 0:
		stage.get_node("Shotgun").shells = shells

func exit_menu() -> void:
	$Menu.queue_free()

func _on_debug_play_pressed() -> void:
	exit_menu()
	var stage = stage_scene.instantiate()
	add_child(stage)
