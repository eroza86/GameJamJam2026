class_name VolumeSlider
extends HSlider

@export_enum("Master", "Music", "SFX") var control_bus: int

func _ready() -> void:
	value = AudioServer.get_bus_volume_db(control_bus)
	print(name)
	print(value)


func _on_value_changed(val: float) -> void:
	AudioServer.set_bus_volume_db(control_bus, val)
	if val <= -50.0:
		AudioServer.set_bus_mute(control_bus, true)
	else:
		AudioServer.set_bus_mute(control_bus, false)
		
