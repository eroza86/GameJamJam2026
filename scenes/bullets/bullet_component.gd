extends Node2D
@export var damage: float
@export var speed: float
@export var kick: float
@onready var bullet = get_parent()

var gun: Node2D
var direction: float = 0

func _ready() -> void:
	var launch_dir = Vector2.RIGHT.rotated(direction).normalized()
	var velocity = launch_dir * speed
	bullet.linear_velocity = velocity
