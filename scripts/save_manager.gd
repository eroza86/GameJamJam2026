class_name SaveGame
extends Resource

const SAVE_GAME_PATH: String = "user://save.tres"

@export var powder_inventory: Dictionary[String, int] = {
	"Fire": 5,
	"Ice": 5,
	"Acid": 0,
	"Lightning": 0,
	"Cloud": 0,
	"Lob": 0,
	"Missile": 0
}

# Gameplay

func add_powder(powderName: String, amount: int) -> void:
	print(powderName)
	powder_inventory[powderName] += amount

# Saving

func write_save() -> void:
	ResourceSaver.save(self, SAVE_GAME_PATH)

func get_temp_save() -> SaveGame:
	return self.duplicate()

static func save_exists() -> bool:
	return ResourceLoader.exists(SAVE_GAME_PATH)



#static func replace_save() -> SaveGame:
#	if save_exists():
#		print("Replacing existing save")
#	return

static func delete_save() -> void:
	if save_exists():
		print("Deleting save")
		DirAccess.remove_absolute(ProjectSettings.globalize_path(SAVE_GAME_PATH))
		# save.remove(SAVE_GAME_PATH)


static func load_save() -> SaveGame:
	if save_exists():
		print("Loaded existing save")
		return ResourceLoader.load(SAVE_GAME_PATH)
	return SaveGame.new()
	#if not ResourceLoader.has_cached(SAVE_GAME_PATH):
	#    return ResourceLoader.load(SAVE_GAME_PATH)
	#return null
