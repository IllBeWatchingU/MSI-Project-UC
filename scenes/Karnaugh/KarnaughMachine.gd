extends StaticBody3D
class_name KarnaughMachine

const State = Constants.State

@export var generate_dont_cares: bool = false

@export_group("Nodes")
@export var reset_button: Node3D
@export var input_display: Display
@export var output_display: Display

var cell_values: Array[State]
var groups: Array[Array] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	for i in range(Constants.GROUP_COUNT):
		groups.append([])
	reset_button.get_node("Button").reset_pressed.connect(randomize_input)
	
	randomize_input()

func randomize_input():
	cell_values = []
	var table = [State.OFF, State.ON]
	if generate_dont_cares: table.append(State.IGNORE)
	for i in range(16):
		cell_values.append(table[randi() % table.size()])
		get_node("Cells/Cell%s" % i).state = cell_values[i]
	
	input_display.set_input_string(cell_values)
	
func add_cell_to_group(cell: Cell, group_id: int):
	groups[group_id].append(cell)
	print(groups)
	
func remove_cell_from_group(cell: Cell, group_id: int):
	var idx := groups[group_id].find(cell)
	if idx != -1: 
		groups[group_id].remove_at(idx)
	print(groups)
	
#region Helpers
func get_cell_by_xy(v: Vector2i) -> Cell:
	var id := Cell.xy2id(v)
	return get_cell_by_id(id)
	
	
func get_cell_by_id(id: int) -> Cell:
	return get_node("Cells/Cell%s" % id)
	

static func bin2gray(v: int) -> int:
	return v ^ (v >> 1)


static func gray2bin(v: int) -> int:
	var mask := v
	var res := v
	while(mask):
		mask >>= 1
		res ^= mask
	return res


#endregion
