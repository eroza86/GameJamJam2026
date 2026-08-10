extends Control

signal goto_game
signal goto_settings
signal quit_game


func _on_play_pressed() -> void:
	goto_game.emit()


func _on_settings_pressed() -> void:
	goto_settings.emit()


func _on_quit_pressed() -> void:
	get_tree().quit()
