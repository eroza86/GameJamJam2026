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
	if bullet is RigidBody2D:
		bullet.linear_velocity = velocity
	elif bullet is Area2D:
		explosion.emitting = true



func _collide(body: Node) -> void:
	bullet.linear_velocity = Vector2.ZERO
	bullet.set_deferred("freeze", true)
	collider.set_deferred("disabled", true)
	if main_particles != null:
		main_particles.emitting = false
	if trail != null:
		trail.emitting = false
	if explosion != null:
		explosion.emitting = true
	
func _dead() -> void:
	bullet.queue_free()

func set_size(size: float) -> void:
	if trail != null:
		trail.scale *= size
	if main_particles != null:
		main_particles.scale *= size
	if explosion != null:
		explosion.scale *= size

func add_powder_amount(element: String, amount: float, augments: Array[float]) -> void:
	damage *= amount/4 * augments[0]
	speed *= (amount/20 + 1) * augments[1]
	kick *= amount/8 * augments[2]
	set_size((amount/5 + 1) * augments[3]) 
	#0.05 - 1.0
	#0.05 is treated as the base value
