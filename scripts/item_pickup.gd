extends RigidBody2D

@export var powder_flask: PowderAmount
@export var heal_amount: int = 2

func _on_body_entered(body: Node) -> void:
	if body is Player:
		if powder_flask == null:
			body.health_component.heal(heal_amount)
			return
		else:
			body.powders[powder_flask.powder.name] += powder_flask.amount
		GlobalSaveHolder.save_game.add_powder(powder_flask)
		GlobalSaveHolder.save_game.write_save()

		queue_free()
