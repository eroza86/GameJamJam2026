extends Node2D

@export var death_scene: PackedScene

func _on_player_died() -> void:
	add_sibling(death_scene.instantiate())


func _on_first_wall_broken() -> void:
	$"../GlobalMusicPlayer".play_level()
