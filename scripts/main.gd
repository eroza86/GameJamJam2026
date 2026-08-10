extends Node

@export var menu_scene: PackedScene
@export var stage_scene: PackedScene
@export var refill_scene: PackedScene
@onready var transition: CanvasLayer = $TransitionLayer

func _ready() -> void:
	$GlobalMusicPlayer.play()

func _on_play_pressed() -> void:
	transition.begin_transition()
	await transition.halfway_transitioned
	$Menu.queue_free()
	goto_refill()
	

func end_game() -> void:
	if $Stage != null:
		$Stage.queue_free()
	if $DeathScreen != null:
		$DeathScreen.queue_free()
	$GlobalMusicPlayer.stop()

func goto_refill() -> void:
	var refill = refill_scene.instantiate()
	add_child(refill)
	refill.connect("start_play_with", start_game)
	

func start_game(shells: Array[Shell]) -> void:
	transition.begin_transition()
	await transition.halfway_transitioned
	$RefillScene.queue_free()
	var stage = stage_scene.instantiate()
	add_child(stage)
	if shells != null and shells.size() > 0:
		stage.get_node("Shotgun").shells = shells
		print(stage.get_children())

	$GlobalMusicPlayer.stop()

func exit_menu() -> void:
	$Menu.queue_free()

func _on_debug_play_pressed() -> void:
	exit_menu()
	var stage = stage_scene.instantiate()
	add_child(stage)
	$GlobalMusicPlayer.stop()

func open_settings() -> void:
	pass

func _on_menu_goto_settings() -> void:
	open_settings()

func retry_to_refill() -> void:
	end_game()
	goto_refill()

func hookup_death(death: CanvasLayer) -> void:
	death.connect("goto_refill", retry_to_refill)
