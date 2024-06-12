extends GateOutlet

# Called when the node enters the scene tree for the first time.
func _ready():
	self.isOutput = true
	self.set_signal_value(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for wire in self.wires:
		wire.set_signal_value(self.signal_value)


func toggle_signal():
	self.set_signal_value(!self.signal_value)
	

func update_signal_value():
	return
	

func set_signal_value(new_signal_value: bool):
	self.signal_value = new_signal_value
	if self.signal_value:
		self.interact_mesh.set_surface_override_material (0, signal_high_material)
	else:
		self.interact_mesh.set_surface_override_material (0, signal_low_material)
	for wire in self.wires:
		wire.set_signal_value(self.signal_value)
