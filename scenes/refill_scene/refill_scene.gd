extends Node2D

@onready var label: Label = $Label
@onready var backButton: Button = $Button
@export var player: CharacterBody2D

var heldBottle: RigidBody2D
var hasMouse: bool = false
var SPEED: float = 10.0

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	print(heldBottle)
	label.text = str(Engine.get_frames_per_second())

func _physics_process(_delta: float) -> void:
	pass


func _on_bottle_is_holding() -> void:
	pass # Replace with function body.


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
