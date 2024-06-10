extends Node

var path = "user://savedata.json"

func write_save(content):
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(JSON.stringify(content))
	file.close()
	file = null

func read_save():
	var file = FileAccess.open(path, FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content
	
func save_current_score(levelName : String, score : String):
	var save = read_save()
	var old_score = save.high_scores[levelName].score.split(":")
	var new_score = score.split(":")
	if new_score[0] < old_score[0] || new_score[0] == old_score[0] && new_score[1] < old_score[1] || new_score[0] == old_score[0] && new_score[1] == old_score[1] && new_score[2] < old_score[2] ||old_score[0] == "00" && old_score[1] == "00" && old_score[2] == "00":
		save.high_scores[levelName].score = score
		save.high_scores[levelName].username = save.current_player_name
		write_save(save)

func create_new_save_file():
	var save_data = {
	"current_player_name": "Player",
	"high_scores": {
		"level_1": {"score": "00:00:00", "username": "Computer"},
		"level_2": {"score": "00:00:00", "username": "Computer"},
		"level_3": {"score": "00:00:00", "username": "Computer"}
		}
	}

	write_save(save_data)
	
func _ready():
	if !FileAccess.open(path, FileAccess.READ):
		create_new_save_file()
