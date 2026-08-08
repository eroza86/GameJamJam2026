extends RigidBody2D
var enemies: Array[Enemy]

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		enemies.append(body)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Enemy:
		enemies.erase(body)

func _physics_process(delta: float) -> void:
	var closest_enemy: Enemy
	var closest_distance: float
	print(enemies.size())
	if enemies.size() > 0:
		closest_enemy = enemies[0]
		closest_distance = global_position.distance_squared_to(enemies[0].global_position)
		for enemy in enemies:
			var distance: float = global_position.distance_squared_to(enemy.global_position)
			if distance < closest_distance:
				closest_enemy = enemy
				closest_distance = distance
		var target_vector = (closest_enemy.global_position - global_position).normalized() * $BulletComponent.speed
		linear_velocity = linear_velocity.slerp(target_vector, 4.0 * delta)
