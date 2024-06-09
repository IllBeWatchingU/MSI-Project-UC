extends Node

var json = JSON.new()
var path = "user://savedata.json"

func write_save(content):
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(json.stringify(content))
	file.close()
	file = null

func read_save():
	var file = FileAccess.open(path, FileAccess.READ)
	var content = json.parse_string(file.get_as_text())
	return content

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
	var content = read_save()
	#print(content.high_scores["level_1"])
	
func _ready():
	if !FileAccess.open(path, FileAccess.READ):
		create_new_save_file()
