extends Node2D

@export var bullet_health: float = 1.0
@export var damage: float = 1.0
@export var speed: float
@export var kick: float
@export var cooldown: float
@export var explosion: CPUParticles2D
@export var main_particles: CPUParticles2D
@export var trail: CPUParticles2D
@export var collider: CollisionShape2D
@export var bullet_collision_area: Area2D
@export var explosion_area: Area2D
@onready var bullet = get_parent()
var bullet_owner: Node2D
var shotgun: Node2D
var velocity
var launchables: Array[Node2D] = []

var gun: Node2D
var direction: float = 0

var exploded: bool = false

func _ready() -> void:
	var launch_dir = Vector2.RIGHT.rotated(direction).normalized()
	velocity = launch_dir * speed
	if bullet is RigidBody2D:
		bullet.linear_velocity = velocity
	elif bullet is Area2D:
		explosion.emitting = true

func _collide(body: Node) -> void:
	if exploded:
		return
	
	if body is StaticBody2D or body is RigidBody2D and body.get_node_or_null("LaunchableComponent") != null or body is TileMapLayer:
		if (body is BreakableWall):
			body.damage(self.damage)
		if (body is Lever):
			body.hit()
		explode()
		return

	if body is Player or body is Enemy:
		body.health_component.take_damage(damage)
		bullet_health -= 20 # TODO: Change this
	
	if bullet_health <= 0:
		explode()

func bullet_clash(body: Node):
	if body.is_in_group("Bullet"):
		var other_bullet = body.get_node_or_null("BulletComponent")
		if other_bullet != null && other_bullet.bullet_owner != self.bullet_owner:
			print("hit bullet")
			if body.global_position.x > self.global_position.x:
				var health_copy: float = bullet_health
				bullet_health -= other_bullet.bullet_health
				other_bullet.bullet_health -= health_copy
	if bullet_health <= 0:
		explode()

func explode() -> void:
	if exploded:
		return
	
	exploded = true
	bullet.linear_velocity = Vector2.ZERO
	bullet.freeze = true
	collider.set_deferred("disabled", true)
	if main_particles != null:
		main_particles.emitting = false
	if trail != null:
		trail.emitting = false
	if explosion != null:
		explosion.emitting = true
	for object in launchables:
		var launch_vector = (object.global_position - bullet.global_position).normalized() * kick
		if bullet.global_position.x > object.global_position.x:
			launch_vector.y = abs(launch_vector.y)
		else:
			launch_vector.y = -abs(launch_vector.y)
		if object is CharacterBody2D:
			object.velocity += launch_vector * kick / 350
			continue
		if object is RigidBody2D:
			object.apply_impulse(launch_vector / 2, object.global_position)
			if object is BombBarrel and !object.exploded:
				object.detonate()
	print(launchables)
	
func _dead() -> void:
	bullet.queue_free()

func set_size(size: float) -> void:
	if trail != null:
		trail.scale *= size
	if main_particles != null:
		main_particles.scale *= size
	if explosion != null:
		explosion.scale *= size
	if collider != null:
		collider.scale *= size
	if bullet_collision_area != null:
		bullet_collision_area.scale *= size
	if explosion_area != null:
		explosion_area.scale *= size

func physics_body_enter(body: Node):
	if body.get_node_or_null("LaunchableComponent") != null:
		launchables.append(body)
	
func physics_body_exit(body: Node):
	if body.get_node_or_null("LaunchableComponent") != null and !exploded:
		launchables.erase(body)

func add_powder_amount(_element: String, amount: float, augments: Array[float]) -> void:
	damage *= (amount/4 + 1) * augments[0]
	speed *= (amount/20 + 1) * augments[1]
	kick *= amount/8 * augments[2]
	set_size((amount/5 + 1) * augments[3]) 
	cooldown *= 1 + augments[4]

	bullet_health = int(amount)
	#0.05 - 1.0
	#0.05 is treated as the base value
