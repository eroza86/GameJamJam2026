extends Node2D

@onready var ui = $"Main Camera/UIControl/Items"
@onready var player = $Player

func _process(_delta: float) -> void:
	print(GlobalSaveHolder.save_game.powder_inventory)
	# ui.text = "Fire: " + str(player.powders["Fire"]) + "\nLightning: " + str(player.powders["Lightning"]) + "\nIce: " + str(player.powders["Ice"]) + "\nAcid: " + str(player.powders["Acid"]) + "\nCloud: " + str(player.powders["Cloud"]) + "\nMissile: " + str(player.powders["Missile"]) + "\nLob: " + str(player.powders["Lob"])


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/refill_scene/refill_scene.tscn")
