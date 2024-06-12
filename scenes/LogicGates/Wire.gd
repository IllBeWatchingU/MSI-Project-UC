extends Interactable
class_name Wire

@onready var signal_high_material: Material = preload("res://assets/textures/signal_high_material.tres")
@onready var signal_low_material: Material = preload("res://assets/textures/signal_low_material.tres")

var input: GateOutlet = null
var output: GateOutlet = null
var signal_value = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_interacted(_interactor):
	self.input.connected = null
	self.input.wires = []
	self.input.update_signal_value()
	self.output.wires.erase(self)
	self.output.update_signal_value()
	var board = get_parent()
	board.wires.erase(self)
	queue_free()


func set_signal_value(new_signal_value: bool):
	self.signal_value = new_signal_value
	if self.signal_value:
		self.interact_mesh.set_surface_override_material (0, signal_high_material)
	else:
		self.interact_mesh.set_surface_override_material (0, signal_low_material)
	self.input.update_signal_value()
