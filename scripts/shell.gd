class_name Shell
extends Resource 

@export var powders: Array[PowderAmount] 

func add_layer(powder: Powder) -> void:
    var top_powder_layer: PowderAmount = powders[powders.size() - 1]

    if top_powder_layer != null and top_powder_layer.powder.name == powder.name:
        top_powder_layer.amount += 1
        return

    powders.append(powder)

