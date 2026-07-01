extends Node

const SAVE_PATH = "user://wario_high_scores.save"

var high_scores = {
	"minigame1": 0,
	"minigame2": 0,
	"minigame3": 0,
	"minigame4": 0,
	"minigame5": 0,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	load_scores()

func update_high_score(game_key: String, new_score: int) -> bool:
	if new_score > high_scores.get(game_key,0):
		high_scores[game_key] = new_score
		save_scores()
		return true
	return false

func save_scores():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(high_scores)

func load_scores():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file:
			var data = file.get_var()
			if data is Dictionary:
				high_scores = data
