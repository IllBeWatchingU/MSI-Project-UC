extends Interactable
class_name GateOutlet

static var selected: GateOutlet = null
var connected: GateOutlet = null
var isOutput: bool 
var wire
var signal_value = false


# Called when the node enters the scene tree for the first time.
func _ready():
	isOutput = self.name == "Output"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if isOutput:
		var input_a = get_parent().find_child("InputA")
		var input_b = get_parent().find_child("InputB")
		self.signal_value = !(input_a.signal_value and input_b.signal_value)
	elif self.wire:
		self.signal_value = self.wire.signal_value


func _on_interacted(_interactor):
	if self.isOutput:
		selected = self
	elif self.connected == null and selected != null:
		_add_wire()
		self.connected = selected
		selected = null


func _add_wire():
	var wire_scene = load("res://scenes/LogicGates/Wire.tscn")
	var wire_instance = wire_scene.instantiate()
	wire_instance.input = self
	wire_instance.output = selected
	var board = get_parent().get_parent()
	board.add_child(wire_instance)
	board.wires.append(wire_instance)
	self.wire = wire_instance
	
	var pos1 = self.global_position
	var pos2 = selected.global_position
	wire_instance.global_position = (pos1 + pos2) / 2
	
	var direction = pos2 - pos1
	var angle_radians = atan2(direction.y, direction.x)
	wire_instance.rotate(Vector3(0, 0, 1), angle_radians)
	wire_instance.scale.x = 4.5 * direction.length() / wire_instance.scale.x


func _exit_tree():
	selected = null
