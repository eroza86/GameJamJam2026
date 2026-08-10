class_name ShellUI
extends StaticBody2D


@export var shellIndex: int = 0

@onready var parent: Node2D = get_parent()
@onready var vbox: VBoxContainer = $MarginContainer/VBoxContainer
@onready var shellRes: Shell
@onready var area: Area2D = $Area2D

var maxShellCapacity: int = 20

func _ready() -> void:
	# shellRes = Shell.new()
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Particles"):
		var string = body.name.rstrip("0123456789")
		if GlobalSaveHolder.save_game.powder_inventory[string] > 0 and parent.shells[shellIndex].current_capacity < 20:
			parent.add_to_shell(parent.associated_powders[string], shellIndex)
			if vbox.get_child_count() < maxShellCapacity:
				var rect = ColorRect.new()
				rect.color = parent.associated_powders[string].color
				rect.custom_minimum_size = Vector2(rect.get_minimum_size().x, 4)
				vbox.add_child(rect)
			else: 
				pass
		body.free()
	
