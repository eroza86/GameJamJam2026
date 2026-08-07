extends Node2D

@export var damage: float
@export var speed: float
@export var kick: float
@export var explosion: CPUParticles2D
@export var main_particles: CPUParticles2D
@export var trail: CPUParticles2D
@export var collider: CollisionShape2D
@onready var bullet = get_parent()


var gun: Node2D
var direction: float = 0

func _ready() -> void:
	var launch_dir = Vector2.RIGHT.rotated(direction).normalized()
	var velocity = launch_dir * speed
	bullet.linear_velocity = velocity



func _collide(body: Node) -> void:
	bullet.linear_velocity = Vector2.ZERO
	collider.set_deferred("disabled", true)
	main_particles.emitting = false
	trail.emitting = false
	explosion.emitting = true
	
func _dead() -> void:
	bullet.queue_free()

func set_size(size: float) -> void:
	trail.scale *= size
	main_particles.scale *= size
	explosion.scale *= size

func add_powder_amount(element: String, amount: float) -> void:
	damage *= amount/4 
	speed *= amount/20 + 1
	kick *= amount/8 
	set_size(amount/5 + 1)
	#0.05 - 1.0
	#0.05 is treated as the base value
