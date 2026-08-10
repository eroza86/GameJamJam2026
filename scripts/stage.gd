extends Node2D

@export var death_scene: PackedScene
var player_died: bool = false

func _on_player_died() -> void:
	if !player_died:
		var death = death_scene.instantiate()
		get_parent().hookup_death(death)
		add_sibling(death)
		player_died = true


func _on_first_wall_broken() -> void:
	$"../GlobalMusicPlayer".play_level()
