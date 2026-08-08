extends Node

@onready var save_game: SaveGame = SaveGame.load_save()

func _ready() -> void:
    save_game.write_save()
    print(save_game)
    print(OS.get_user_data_dir())