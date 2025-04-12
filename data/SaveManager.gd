extends Node

const SAVE_PATH := "user://highscore.json"
var high_scores: Array = []

func _ready():
	load_high_scores()

func add_score(new_score: int) -> void:
	high_scores.append(new_score)
	high_scores.sort()
	high_scores.reverse()
	high_scores = high_scores.slice(0, 10)
	save_high_scores()

func save_high_scores() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data = { "scores": high_scores }
	file.store_string(JSON.stringify(data))
	file.close()

func load_high_scores() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
		if typeof(data) == TYPE_DICTIONARY and data.has("scores"):
			high_scores = data["scores"]
		file.close()
	else:
		high_scores = []

func clear_save_data():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
		file.store_string("{}")
		file.close()
		high_scores.clear()
