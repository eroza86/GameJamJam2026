extends Node2D

@export var target: CharacterBody2D
@export var SPEED: float
@onready var barrel = $barrel

# Shells

@export var shells: Array[Shell] = [null, null, null]
@export_range(0, 2, 1) var current_shell: int = 0 # Index of above array

var can_shoot: bool
var cooldown_timer: Timer

func _ready() -> void:
	cooldown_timer = Timer.new()
	cooldown_timer.one_shot = true
	cooldown_timer.timeout.connect(cooldown_timeout)
	add_child(cooldown_timer)
	can_shoot = true
	
func cooldown_timeout():
	can_shoot = true

func shoot_shell() -> void:
	if shells[current_shell] == null or can_shoot == false:
		return
	
	can_shoot = false
	var cooldown_time: float = 0
	
	var mod_powder_augment: Array[float] = [1, 1, 1, 1, 1]
	for powder_amount in shells[current_shell].powders:
		# var bullet_instance = bullet.instantiate()
		var powder: Powder = powder_amount.powder
		var amount: int = powder_amount.amount
		
		
		if powder is BasePowder:
			#TODO: Change values based on amount. Call bullet?
			var bullet_instance = powder_amount.powder.bullet.instantiate()
			bullet_instance.global_position = barrel.global_position
			var bullet_data = bullet_instance.get_node("BulletComponent")
			var bullet_direction = self.rotation + deg_to_rad(randf_range(-15.0, 15.0))

			bullet_data.direction = bullet_direction
			bullet_instance.rotation = bullet_direction

			bullet_data.add_powder_amount(powder.name, amount, mod_powder_augment)
			cooldown_time += bullet_data.cooldown
			mod_powder_augment = [1, 1, 1, 1, 1]
			
			add_sibling(bullet_instance)
			target.velocity.y *= 0.3
			target.velocity += Vector2.RIGHT.rotated(self.rotation).normalized() * bullet_data.kick * -1
			
		if powder is ModifierPowder:
			mod_powder_augment[0] += powder.damage * amount / 20
			mod_powder_augment[1] += powder.speed * amount / 20
			mod_powder_augment[2] += powder.kick * amount / 20
			mod_powder_augment[3] += powder.size * amount / 20
			mod_powder_augment[4] += powder.cooldown * amount / 20
	
	cooldown_timer.wait_time = cooldown_time
	cooldown_timer.start()
 
func _physics_process(delta: float) -> void:
	if target != null:
		print(target)
		global_position = lerp(global_position, target.global_position, SPEED * delta)
	
	if target is Player:
		look_at(get_global_mouse_position())
	

		if Input.is_action_just_pressed("shoot"):
			shoot_shell()
