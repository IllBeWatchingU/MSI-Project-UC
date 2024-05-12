extends "res://scripts/Interactable.gd"
class_name Cell

const State = KarnaughMachine.State
const STATE_STRING = {State.OFF: "0", State.ON: "1", State.IGNORE: "X"}

@onready var karnaugh_machine: KarnaughMachine = owner.get_node("%KarnaughMachine")

@export var id: int = 0:
	set(value):
		id = value
		$IdLabel.text = "%s" % gray_id
	
@export var state: State = State.OFF:
	set(value):
		state = value
		$StateLabel.text = STATE_STRING[value]

#region Grid position getters
var gray_id: int:
	get: return KarnaughMachine.bin2gray(id)
	
var grid_pos: Vector2i:
	get: return Vector2i(grid_x, grid_y)
	
var grid_x: int:
	get: return id%4

var grid_y: int:
	get: return id/floor(4)
#endregion
	
#region Neighbour cell getters
var left: Cell:
	get: return get_neighbour(Vector2i.LEFT)
	
var right: Cell:
	get: return get_neighbour(Vector2i.RIGHT)
	
var up: Cell:
	get: return get_neighbour(Vector2i.UP)
	
var down: Cell:
	get: return get_neighbour(Vector2i.DOWN)
#endregion

static func xy2id(v: Vector2i) -> int:
	return v.y*4 + v.x

func get_neighbour(v: Vector2i) -> Cell:
	var p = grid_pos + v
	p = Vector2i(posmod(p.x, 4), posmod(p.y, 4))
	return karnaugh_machine.get_cell_by_xy(p)

func toggle_state():
	state = ((state + 1) % State.size()) as State

func _on_interacted(_interactor):
	left.toggle_state()
