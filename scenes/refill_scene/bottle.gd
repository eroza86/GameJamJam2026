extends RigidBody2D

@export var fireParticle: PackedScene
@export var iceParticle: PackedScene
@export var acidParticle: PackedScene
@export var lightningParticle: PackedScene
@export var cloudParticle: PackedScene
@export var lobParticle: PackedScene
@export var missileParticle: PackedScene
@onready var is_mouse_over: bool
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var parent: Node2D = $"../"
@onready var label: Label = $Label
@onready var marker: Marker2D = $Marker2D
@onready var powders: Dictionary[String, int] = GlobalSaveHolder.save_game.powder_inventory

var type: String
var is_dragging: bool
var SPEED: float = .08
var TILTSPEED: float = .05

func _ready() -> void:
	label.text = type

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

	
func _on_timer_timeout() -> void:
	var angle = wrapf(rad_to_deg(rotation), -180.0, 180.0)
	var particle = RigidBody2D
	if abs(angle) > 120:
		match type:
			"Fire":
				particle = fireParticle.instantiate()
			"Ice":
				particle = iceParticle.instantiate()
			"Acid":
				particle = acidParticle.instantiate()
			"Lightning":
				particle = lightningParticle.instantiate()
			"Cloud":
				particle = cloudParticle.instantiate()
			"Lob":
				particle = lobParticle.instantiate()
			"Missile":
				particle = missileParticle.instantiate()

		if powders[type] != 0:
			get_parent().add_child(particle)

			particle.global_position = marker.global_position
			particle.reset_physics_interpolation()

			particle.sleeping = false
			
			powders[type] = powders[type] - 1
			
			print(powders[type])
		else: 
			pass
