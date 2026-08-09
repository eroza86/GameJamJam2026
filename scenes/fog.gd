extends Node2D
@onready var sprite: Sprite2D = $Sprite2D
var target_opacity: float = 1.0

func fade_out():
	target_opacity = 0.0
	
func fade_in():
	target_opacity = 1.0
	
func _process(delta: float) -> void:
	sprite.modulate.a = lerp(sprite.modulate.a, target_opacity, 8 * delta)
	if abs(sprite.modulate.a - target_opacity) < 0.05:
		sprite.modulate.a = target_opacity
