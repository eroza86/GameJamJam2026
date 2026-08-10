extends CanvasLayer

signal halfway_transitioned

func begin_transition() -> void:
	$AnimationPlayer.play("fade")
	await $AnimationPlayer.animation_finished
	halfway_transitioned.emit()
	$AnimationPlayer.play_backwards("fade")
