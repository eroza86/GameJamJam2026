extends Node2D

@export var death_scene: PackedScene
@onready var transition: AnimationPlayer = $TransitionLayer/AnimationPlayer

func _ready() -> void:
	transition.play("fade_in")

func _on_player_died() -> void:
	add_sibling(death_scene.instantiate())
