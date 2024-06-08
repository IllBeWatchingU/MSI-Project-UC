extends "res://scripts/Interactable.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_focused(_interactor):
	pass
	
	
func _on_unfocused(_interactor):
	pass


func _on_interacted(interactor):
	place_nand_gate(interactor)


func place_nand_gate(interactor):
	var new_gate = load("res://scenes/LogicGates/NandGate.tscn")
	if new_gate:
		var instance = new_gate.instantiate()
		instance.global_transform.origin = interactor.get_collision_point() - Vector3(0, 1.415, -4.5)
		add_child(instance)
	else:
		print("Failed to load object scene.")
