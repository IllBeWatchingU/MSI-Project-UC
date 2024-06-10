extends "res://scripts/Interactable.gd"

var wires = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_interacted(interactor):
	place_nand_gate(interactor)


func place_nand_gate(interactor):
	var new_gate = load("res://scenes/LogicGates/NandGate.tscn")
	if new_gate:
		var instance = new_gate.instantiate()
		add_child(instance)
		instance.global_position = interactor.get_collision_point()
	else:
		print("Failed to load object scene.")
