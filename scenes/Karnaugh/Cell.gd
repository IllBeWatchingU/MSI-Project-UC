extends "res://scripts/Interactable.gd"

enum State {OFF, ON, IGNORE}
const STATE_STRING = {State.OFF: "0", State.ON: "1", State.IGNORE: "X"}

@export var id: int = 0:
	set(value):
		id = value
		$IdLabel.text = "%s" % gray_id
	
@export var state: State = State.OFF:
	set(value):
		state = value
		$StateLabel.text = STATE_STRING[value]
		
var gray_id: int:
	get: return bin2gray(id)
	
var grid_x: int:
	get: return id%4

var grid_y: int:
	get: return id/floor(4)

		
func toggle_state():
	state = ((state + 1) % State.size()) as State


func bin2gray(v: int) -> int:
	return v ^ (v >> 1)


func _on_interacted(_interactor):
	toggle_state()
