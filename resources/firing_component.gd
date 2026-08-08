extends Node2D

@export var shotgun: Node2D
var player: Player = null

func _on_timer_timeout() -> void:
	shotgun.shoot_shell()

func _physics_process(delta: float) -> void:
	if shotgun != null and player != null:
		shotgun.look_at(player.global_position)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		player = null
