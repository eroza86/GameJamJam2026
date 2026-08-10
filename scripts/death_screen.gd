extends CanvasLayer

signal goto_refill
signal goto_menu

func _ready() -> void:
	$AnimationPlayer.play("enter")


func _on_button_pressed() -> void:
	goto_refill.emit()


func _on_menu_pressed() -> void:
	goto_menu.emit()
	get_tree().reload_current_scene()
