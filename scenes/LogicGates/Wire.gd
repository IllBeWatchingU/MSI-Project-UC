extends Interactable
class_name Wire

var input: GateOutlet = null
var output: GateOutlet = null
var signal_value = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.signal_value = self.output.signal_value


func _on_interacted(interactor):
	self.input.connected = null
	self.input.wire = null
	var board = get_parent()
	board.wires.erase(self)
	queue_free()
