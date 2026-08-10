class_name Shell
extends Resource 

@export var powders: Array[PowderAmount] 
@export var current_capacity: int = 0
const MAX_CAPACITY: int = 20


func add_layer(powder: Powder) -> void:
	var powderAmount: PowderAmount
	current_capacity += 1
	if powders.size() == 0:
		powderAmount = PowderAmount.new()
		powderAmount.powder = powder
		powderAmount.amount = 1
		powders.append(powderAmount)
		return
		
	var top_powder_layer: PowderAmount = powders[powders.size() - 1]

	if top_powder_layer != null and top_powder_layer.powder.name == powder.name:
		top_powder_layer.amount += 1
		return

	powderAmount = PowderAmount.new()
	powderAmount.powder = powder
	powderAmount.amount = 1
	powders.append(powderAmount)
