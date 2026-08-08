class_name Enemy
extends CharacterBody2D

@export var health_component: HealthComponent
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

func _physics_process(delta: float) -> void:
	if movement_component != null:
		movement_component.do_movement()
		move_and_slide()

func on_death() -> void:
	queue_free()
	firing_component.shotgun.queue_free()




	


func _on_health_component_died() -> void:
	pass # Replace with function body.
