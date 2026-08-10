class_name BombBarrel
extends RigidBody2D
@onready var explosion: CPUParticles2D = $Explosion
@onready var collider: CollisionShape2D = $Collider
@onready var sprite: TileMapLayer = $tile
var explode_timer: Timer
var launchables: Array[Node2D] = []
var exploded: bool = false

func _ready() -> void:
	explode_timer = Timer.new()
	explode_timer.wait_time = randf_range(0.1, 0.65)
	explode_timer.one_shot = true
	explode_timer.timeout.connect(explode)
	add_child(explode_timer)

func detonate():
	explode_timer.start()

func explode():
	exploded = true
	explosion.emitting = true
	self.set_deferred("freeze", true)
	collider.set_deferred("disabled", true)
	for object in launchables:
		var launch_vector = (object.global_position - self.global_position).normalized() * 65
		if self.global_position.x > object.global_position.x:
			launch_vector.y = abs(launch_vector.y)
		else:
			launch_vector.y = -abs(launch_vector.y)
		if object is CharacterBody2D:
			object.velocity += launch_vector * 20
			continue
		if object is RigidBody2D:
			object.apply_impulse(launch_vector / 2, object.global_position)
			if object is BombBarrel and !object.exploded:
				object.detonate()
	sprite.hide()

func dead():
	queue_free()

func physics_body_enter(body: Node):
	if body.get_node_or_null("LaunchableComponent") != null and !exploded:
		launchables.append(body)
		print("added: " + body.to_string())
	
func physics_body_exit(body: Node):
	if body.get_node_or_null("LaunchableComponent") != null and !exploded:
		launchables.erase(body)
