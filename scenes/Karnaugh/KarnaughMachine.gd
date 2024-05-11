extends StaticBody3D

enum State {OFF, ON, IGNORE}

signal generated(values: Array)

@export var generate_dont_cares: bool = false

var cell_values: Array[State]
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	randomize_input()

func randomize_input():
	cell_values = []
	var table = [State.OFF, State.ON]
	if generate_dont_cares: table.append(State.IGNORE)
	for i in range(16):
		cell_values.append(table[randi() % table.size()])
		get_node("Cells/Cell%s" % i).state = cell_values[i]
	generated.emit(cell_values)


func _on_reset_pressed():
	randomize_input()
