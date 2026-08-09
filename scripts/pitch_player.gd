extends AudioStreamPlayer2D

@export var pitch_difference: float = 0.1

func randomize_pitch() -> void:
	pitch_scale = randf_range(1.0 - pitch_difference, 1.0 + pitch_difference)
