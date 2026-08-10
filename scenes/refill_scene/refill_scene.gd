extends Node2D

@onready var backButton: Button = $Button
@onready var powders: Dictionary[String, int] = GlobalSaveHolder.save_game.powder_inventory
@onready var pickupBottle: AudioStreamPlayer2D = $PickupBottle
@export var bottle: PackedScene
@export var stage: PackedScene
@export var associated_powders: Dictionary[String, Powder]
@export var shells: Array[Shell] = [null, null, null]
@export var load_shells: Array[Shell] = [null, null, null]
var elements: Array[String] = [ "Fire", "Ice", "Acid", "Lightning", "Cloud", "Lob", "Missile" ] 


@onready var markers: Array[Marker2D] = [
	$"FlaskSpawnMarkers/1", 
	$"FlaskSpawnMarkers/2",
	$"FlaskSpawnMarkers/3",
	$"FlaskSpawnMarkers/4",
	$"FlaskSpawnMarkers/5",
	$"FlaskSpawnMarkers/6",
	$"FlaskSpawnMarkers/7"
	]

var heldBottle: RigidBody2D
var hasMouse: bool = false
var SPEED: float = 10.0

signal start_play_with(shells: Array[Shell])

func _ready() -> void:
	shells = load_shells
	initialize_scene()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
func initialize_scene():
	# The increment value
	var powder_type_enum: int = 0
	for item in powders:
		# Amount of powder
		var amount = powders[item]
		if amount <= 0:
			powders[item] = 0
			pass
		else:
			var bottleNode = bottle.instantiate()
			bottleNode.type = item
			bottleNode.global_position = markers[powder_type_enum].global_position
			add_child(bottleNode)
		powder_type_enum += 1


# Pour into a shell
func add_to_shell(powder: Powder, shell_index: int) -> void:
	var powder_name: String = powder.name

	# Subtract 1 from dictionary (dual reference with this system)
	GlobalSaveHolder.save_game.powder_inventory[powder_name] -= 1

	# Add that 1 to the shell
	shells[shell_index].add_layer(powder)
	
	GlobalSaveHolder.save_game.write_save()


func _on_go_pressed() -> void:
	start_play_with.emit(shells)
