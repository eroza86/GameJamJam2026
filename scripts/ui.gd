extends Control


@onready var fireLabel: Label = $fireSprite/fireLabel
@onready var iceLabel: Label = $iceSprite/iceLabel
@onready var acidLabel: Label = $acidSprite/acidLabel
@onready var lightningLabel: Label = $lightningSprite/lightningLabel
@onready var cloudLabel: Label = $cloudSprite/cloudLabel
@onready var lobLabel: Label = $lobSprite/lobLabel
@onready var missileLabel: Label = $missileSprite/missileLabel

func _process(_delta: float) -> void:
	fireLabel.text = ": " + str(GlobalSaveHolder.save_game.powder_inventory["Fire"])
	
	iceLabel.text = ": " + str(GlobalSaveHolder.save_game.powder_inventory["Ice"])
	
	acidLabel.text = ": " + str(GlobalSaveHolder.save_game.powder_inventory["Acid"])
	
	lightningLabel.text = ": " + str(GlobalSaveHolder.save_game.powder_inventory["Lightning"])
	
	cloudLabel.text = ": " + str(GlobalSaveHolder.save_game.powder_inventory["Cloud"])
	
	lobLabel.text = ": " + str(GlobalSaveHolder.save_game.powder_inventory["Lob"])
	
	missileLabel.text = ": " + str(GlobalSaveHolder.save_game.powder_inventory["Missile"])
