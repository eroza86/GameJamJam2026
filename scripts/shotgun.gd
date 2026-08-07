extends Node2D
@export var target: Node2D
@export var SPEED: float
@export var bullet: PackedScene
@onready var barrel = $barrel

func _physics_process(delta: float) -> void:
	if target != null:
		global_position = global_position.lerp(target.position, SPEED * delta)
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("shoot"):
		var bullet_instance = bullet.instantiate()
		bullet_instance.global_position = barrel.global_position
		bullet_instance.get_node("BulletComponent").direction = self.rotation
		add_sibling(bullet_instance)
