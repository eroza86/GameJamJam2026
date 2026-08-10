extends Node2D

@export var death_scene: PackedScene

func _on_player_died() -> void:
	var death = death_scene.instantiate()
	get_parent().hookup_death(death)
	add_sibling(death)


func _on_first_wall_broken() -> void:
	$"../GlobalMusicPlayer".play_level()
