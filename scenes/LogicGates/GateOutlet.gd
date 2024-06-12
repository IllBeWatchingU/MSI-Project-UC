extends Interactable
class_name GateOutlet

@onready var signal_high_material: Material = preload("res://assets/textures/signal_high_material.tres")
@onready var signal_low_material: Material = preload("res://assets/textures/signal_low_material.tres")
@onready var signal_null_material: Material = preload("res://assets/textures/signal_null_material.tres")

static var selected: GateOutlet = null
var connected: GateOutlet = null
var isOutput: bool 
var wires = []
var signal_value = false


# Called when the node enters the scene tree for the first time.
func _ready():
	isOutput = self.name == "Output"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


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
	
	self.wires.append(wire_instance) 
	self.selected.wires.append(wire_instance)
	
	var pos1 = self.global_position
	var pos2 = selected.global_position
	wire_instance.global_position = (pos1 + pos2) / 2
	
	var direction = pos2 - pos1
	var angle_radians = atan2(direction.y, direction.x)
	wire_instance.rotate(Vector3(0, 0, 1), angle_radians)
	wire_instance.scale.x = 4.5 * direction.length() / wire_instance.scale.x


func _exit_tree():
	selected = null
	

func set_signal_value(new_signal_value: bool):
	self.signal_value = new_signal_value
	if self.signal_value:
		self.interact_mesh.set_surface_override_material (0, signal_high_material)
	else:
		self.interact_mesh.set_surface_override_material (0, signal_low_material)
		

func update_signal_value():
	var input_a = get_parent().find_child("InputA")
	var input_b = get_parent().find_child("InputB")
	var output = get_parent().find_child("Output")
	if self.isOutput:
		if input_a.wires or input_b.wires:
			self.set_signal_value(!(input_a.signal_value and input_b.signal_value))
			for wire in wires:
				wire.set_signal_value(self.signal_value)
		else:
			self.set_signal_value(false)
			self.interact_mesh.set_surface_override_material (0, signal_null_material)
	else:
		if self.wires:
			self.set_signal_value(self.wires[0].signal_value)
		else:
			self.interact_mesh.set_surface_override_material (0, signal_null_material)
		output.update_signal_value()
