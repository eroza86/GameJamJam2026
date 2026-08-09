extends StaticBody2D

@onready var parent: Node2D = get_parent()
@onready var colorRects: Array[ColorRect] = [
	$"MarginContainer/VBoxContainer/1",
	$"MarginContainer/VBoxContainer/2",
	$"MarginContainer/VBoxContainer/3",
	$"MarginContainer/VBoxContainer/4",
	$"MarginContainer/VBoxContainer/5",
	$"MarginContainer/VBoxContainer/6",
	$"MarginContainer/VBoxContainer/7",
	$"MarginContainer/VBoxContainer/8",
	$"MarginContainer/VBoxContainer/9",
	$"MarginContainer/VBoxContainer/10",
	$"MarginContainer/VBoxContainer/11",
	$"MarginContainer/VBoxContainer/12",
	$"MarginContainer/VBoxContainer/13",
	$"MarginContainer/VBoxContainer/14",
	$"MarginContainer/VBoxContainer/15",
	$"MarginContainer/VBoxContainer/16",
	$"MarginContainer/VBoxContainer/17",
	$"MarginContainer/VBoxContainer/18",
	$"MarginContainer/VBoxContainer/19"
]

@onready var shellRes: Shell
@onready var area: Area2D = $Area2D

func _ready() -> void:
	shellRes = Shell.new()

func _on_area_2d_body_entered(body: Node2D) -> void:
	
	var particleType: Powder
	match body.name:
		"Acid":
			particleType = parent.associated_powders[body.name]
		"Cloud":
			particleType = parent.associated_powders[body.name]
		"Fire":
			particleType = parent.associated_powders[body.name]
		"Ice":
			particleType = parent.associated_powders[body.name]
		"Lightning":
			particleType = parent.associated_powders[body.name]
		"Lob":
			particleType = parent.associated_powders[body.name]
		"Missile":
			particleType = parent.associated_powders[body.name]
			
	shellRes.add_layer(particleType)
	
	for items in colorRects:
		if shellRes[body.name] == 0:
			items.color.a = 0
		else:
			items.color = shellRes[body.name].color

		
	
