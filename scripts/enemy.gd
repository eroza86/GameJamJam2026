extends CharacterBody2D

@export var movement_component: Node2D
@export var firing_component: Node2D
@export var shotgun_scene: PackedScene
@export var shell: Shell

func _ready() -> void:
	var shotgun = shotgun_scene.instantiate()
	shotgun.shells[0] = shell
	shotgun.target = self
	add_sibling.call_deferred(shotgun)
	firing_component.shotgun = shotgun
	shotgun.global_position = global_position




	
