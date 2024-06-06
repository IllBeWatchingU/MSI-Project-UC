extends "res://scripts/Interactable.gd"
class_name Cell

const State = Constants.State
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

var group_idx: int = -1:
	set(value):
		group_idx = value
		if group_idx == -1:
			$InteractMesh.material_override = null
		else:
			var group_mesh: Material = $InteractMesh.mesh.material.duplicate()
			group_mesh.albedo_color = Constants.GROUP_COLORS[group_idx]
			$InteractMesh.material_override = group_mesh
			


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
	
static func id2xy(i: int) -> Vector2i:
	return Vector2i(i % 4, i / floor(4))

func get_neighbour(v: Vector2i) -> Cell:
	var p = grid_pos + v
	p = Vector2i(posmod(p.x, 4), posmod(p.y, 4))
	return karnaugh_machine.get_cell_by_xy(p)

func toggle_state():
	state = ((state + 1) % State.size()) as State

func toggle_group(idx: int):
	if group_idx != -1:
		karnaugh_machine.remove_cell_from_group(self, group_idx)
		group_idx = -1
	else:
		karnaugh_machine.add_cell_to_group(self, idx)
		group_idx = idx

func _on_interacted(interactor):
	toggle_group(interactor.owner.selected_group_id)
