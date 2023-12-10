extends Node

var estado = {
	"current_scene" = "fase",
	"transition_scene" = false,
	"capuccino_count" = 1,
	"emocao_count" = 0,
}

var current_scene = "fase"
var transition_scene = false

var capuccino_count: int = 1
var emocao_count: int = 0

func getEmocao():
	return emocao_count


#SALVAMENTO

const SAVE_GAME_PATH =  "user://progresso.save"
func save_game(): #tambem serve pra dar overwrite
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	file.store_var(estado)

func save_exists():
	if FileAccess.file_exists(SAVE_GAME_PATH):
		return true
	else:
		return false

func load_data():
	if FileAccess.file_exists(SAVE_GAME_PATH):
		var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
		estado = file.get_var()
