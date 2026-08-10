class_name Powder
extends Resource

@export var name: String
var color: Color

func ready() -> void:
	match name:
		"Fire": 
			color = Color("b2330d")
		"Acid": 
			color = Color("007a00")
		"Cloud":
			color = Color("727272")
		"Lightning":
			color = Color("ddb400")
		"Lob":
			color = Color("d300ab")
		"Missile":
			color = Color("f0f0f0")
