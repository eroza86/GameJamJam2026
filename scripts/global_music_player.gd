extends AudioStreamPlayer

@export var menu_music: AudioStream
@export var level_music: AudioStream

func play_level() -> void:
	stream = level_music
	play()
