extends Node2D

@export var target: Node2D
@export var SPEED: float
@export var bullet: PackedScene
@onready var barrel = $barrel

# Shells

@export var shells: Array[Shell] = [null, null, null]
@export_range(0, 2, 1) var current_shell: int = 0 # Index of above array

func shoot_shell() -> void:
	if shells[current_shell] == null:
		return
	
	for powder_amount in shells[current_shell].powders:
		# var bullet_instance = bullet.instantiate()
		var powder = powder_amount.powder
		var amount = powder_amount.amount
		
		if powder is BasePowder:
			#TODO: Change values based on amount. Call bullet?
			var bullet_instance = powder_amount.powder.bullet.instantiate()
			bullet_instance.global_position = barrel.global_position
			bullet_instance.get_node("BulletComponent").direction = self.rotation + deg_to_rad(randf_range(-15.0, 15.0))
			add_sibling(bullet_instance)

 
func _physics_process(delta: float) -> void:
	if target != null:
		global_position = global_position.lerp(target.position, SPEED * delta)
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("shoot"):
		shoot_shell()
		
