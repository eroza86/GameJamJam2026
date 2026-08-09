extends Node2D

@onready var label: Label = $Label
@onready var backButton: Button = $Button
@onready var powders: Dictionary[String, int] = GlobalSaveHolder.save_game.powder_inventory
@export var bottle: PackedScene
@export var stage: PackedScene
@export var associated_powders: Dictionary[String, Powder]
@export var shells: Array[Shell] = [null, null, null]

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

func _ready() -> void:
	# createShell(4, BasePowder.new(), 0, 0, 0, 0, 0, 0)
		
	initialize_scene()

func _process(_delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
func initialize_scene():
	dispurse_markers()
	# 
	var powder_type_enum: int = 0
	for item in powders:
		# Amount of powder
		var amount = powders[item]
		if amount == 0:
			# Don't generate an empty bottle
			pass
		else:
			var bottleNode = bottle.instantiate()
			bottleNode.global_position = markers[powder_type_enum].global_position
			add_child(bottleNode)
		powder_type_enum += 1
			
# Creates a shell. If not using any of one powder, put "0" as the scales/amount
#func createShell(amount: int, powderType: Powder, element: int, damageScale: int, 
#speedScale: int, kickScale: int, sizeScale: int, cooldownScale: int) -> Shell:
#	var shell = Shell.new()
#	shell.powders.append(PowderAmount.new())
#	shell.powders[0] = amount
#	shell.powders[0].powder = powderType
#	if shell.PowderAmount.Powder is BasePowder:
#		shell.PowderAmount.Powder.Element = element
#	elif shell.PowderAmount.Powder is ModifierPowder:
#		shell.PowderAmount.Powder.Damage = damageScale
#		shell.PowderAmount.Powder.Speed = speedScale
#		shell.PowderAmount.Powder.Kick = kickScale
#		shell.PowderAmount.Powder.Size = sizeScale
#		shell.PowderAmount.Powder.Cooldown = cooldownScale
#	return shell
		
			
func dispurse_markers() -> void:
	var count = 0
	var distance = get_viewport().size.x / 7
	for marker in markers:
		marker.global_position = Vector2(count * distance, 400)
		count = count + 1
		print(marker.global_position)
	

# Pour into a shell
func add_to_shell(powder_flask: PowderAmount, shell_index: int) -> void:
	var powder_name: String = powder_flask.powder.name

	# Subtract 1 from temp flask
	powder_flask.amount -= 1

	# Subtract 1 from dictionary (dual reference with this system)
	GlobalSaveHolder.save_game.powder_inventory[powder_name] -= 1

	# Add that 1 to the shell
	shells[shell_index].add_layer(powder_flask.powder)
	
	GlobalSaveHolder.save_game.write_save()
