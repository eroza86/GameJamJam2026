extends Node2D

@onready var label: Label = $Label
@onready var backButton: Button = $Button
@export var bottle: PackedScene

var heldBottle: RigidBody2D
var hasMouse: bool = false
var SPEED: float = 10.0

func _ready() -> void:
	initialize_scene()

func _process(_delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
func initialize_scene():
	for item in GlobalSaveHolder.playerInv:
		var count = GlobalSaveHolder.powders[item]
		if count == 0:
			print(item)
		else:
			var bottleNode = bottle.instantiate()
			add_child(bottleNode)
