extends RigidBody2D

@export var powder_flask: PowderAmount
@export var heal_amount: int = 2

func _on_body_entered(body: Node) -> void:
	if body is Player:
		if powder_flask == null:
			body.health_component.heal(heal_amount)
			return
		else:
			body.addPowder(powder_flask.powder.name, powder_flask.amount)
			print(body.powders)
			
		queue_free()
