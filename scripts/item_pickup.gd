extends RigidBody2D

@export var powder_flask: PowderAmount
@export var heal_amount: int = 2
@onready var label: Label = $Label

func _process(_delta: float) -> void:
	label.text = str(powder_flask.amount)
	label.modulate = powder_flask.powder.color

func _on_body_entered(body: Node) -> void:
	if body is Player:
		$AudioStreamPlayer2D.play()
		if powder_flask == null:
			body.health_component.heal(heal_amount)
			return
		else:
			GlobalSaveHolder.save_game.add_powder(powder_flask.powder.name, powder_flask.amount)
			GlobalSaveHolder.save_game.write_save()
			
		queue_free()
