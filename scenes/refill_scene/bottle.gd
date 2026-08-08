extends RigidBody2D

@onready var is_mouse_over: bool
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var parent: Node2D = $"../"

var is_dragging: bool
var SPEED: float = .08
var TILTSPEED: float = .05

func _on_mouse_entered() -> void:
	is_mouse_over = true

func _on_mouse_exited() -> void:
	is_mouse_over = false

func _process(_delta: float) -> void:
	
	collision.global_position = self.global_position

	if Input.is_action_pressed("shoot"):
		if is_mouse_over:
			is_dragging = true
	else:
		is_dragging = false
			
	if parent.heldBottle != null && parent.heldBottle != self:
		return
		
	if is_dragging == true:
		parent.heldBottle = self
		self.freeze = true
		global_position = global_position.lerp(get_global_mouse_position(), SPEED)

		if Input.is_action_pressed("move_left"):
			rotation = move_toward(rotation, rotation - .05, TILTSPEED)
		elif Input.is_action_pressed("move_right"):
			rotation = move_toward(rotation, rotation + .05, TILTSPEED)
	else:
		parent.heldBottle = null
		self.freeze = false
