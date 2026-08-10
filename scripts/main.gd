extends Node

@export var menu_scene: PackedScene
@export var stage_scene: PackedScene
@export var refill_scene: PackedScene
@onready var menuMusic: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var transition: AnimationPlayer = $TransitionLayer/AnimationPlayer

func _ready() -> void:
	transition.play("fade_in")
	menuMusic.play()
	await get_tree().create_timer(1).timeout

func _on_play_pressed() -> void:
	transition.play("fade_out")
	await get_tree().create_timer(1).timeout
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
	transition.play("fade_out")
	await get_tree().create_timer(1).timeout
	exit_menu()
	var stage = stage_scene.instantiate()
	add_child(stage)
