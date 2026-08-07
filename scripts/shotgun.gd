extends Node2D

@export var target: CharacterBody2D
@export var SPEED: float
@export var bullet: PackedScene
@onready var barrel = $barrel

# Shells

@export var shells: Array[Shell] = [null, null, null]
 
func _physics_process(delta: float) -> void:
	if target != null:
		global_position = global_position.lerp(target.position, SPEED * delta)
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("shoot"):
		var bullet_instance = bullet.instantiate()
		bullet_instance.global_position = barrel.global_position		
		var bullet_data = bullet_instance.get_node("BulletComponent")
		bullet_data.direction = self.rotation
		target.velocity.y *= 0.3
		target.velocity += Vector2.RIGHT.rotated(self.rotation).normalized() * bullet_data.kick * -1
		add_sibling(bullet_instance)
