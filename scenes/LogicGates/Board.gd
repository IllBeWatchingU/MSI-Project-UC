extends "res://scripts/Core/Interactable.gd"

var wires = []
var nand_gates = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_interacted(interactor):
	place_nand_gate(interactor)


func place_nand_gate(interactor):
	var gate_scene = load("res://scenes/LogicGates/NandGate.tscn")
	var new_gate = gate_scene.instantiate()
	add_child(new_gate)
	self.nand_gates.append(new_gate)
	new_gate.global_position = interactor.get_collision_point()
