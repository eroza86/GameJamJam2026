class_name Enemy
extends CharacterBody2D

@export var health_component: HealthComponent
@export var movement_component: Node2D
@export var firing_component: Node2D
@export var item_scene: PackedScene
@export var shotgun_scene: PackedScene
@export var shell: Shell

@export var minDropCount: int = 0
@export var maxDropCount: int = 4
@export var powders: Array[BasePowder]  
var weights: PackedFloat32Array = [50.0, 50.0, 40.0, 40.0, 30.0, 20.0, 20.0]

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	var shotgun = shotgun_scene.instantiate()
	shotgun.shells[0] = shell
	shotgun.target = self
	add_sibling.call_deferred(shotgun)
	firing_component.shotgun = shotgun
	shotgun.global_position = global_position

func _physics_process(_delta: float) -> void:
	if firing_component != null:
		firing_component.shotgun.global_position = global_position
	if movement_component != null:
		movement_component.do_movement(_delta)
		move_and_slide()

func on_death() -> void:
	var item = item_scene.instantiate()
	call_deferred("add_sibling", item)
	item.global_position = global_position
	item.powder_flask = PowderAmount.new()
	item.powder_flask.amount = rng.randi_range(minDropCount, maxDropCount)
	item.powder_flask.powder = get_weighted_item()
	firing_component.shotgun.queue_free()
	queue_free()
	
func get_weighted_item() -> Powder:
	var index = rng.rand_weighted(weights)
	return powders[index]




	
