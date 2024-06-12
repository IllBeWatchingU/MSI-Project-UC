extends GateOutlet


# Called when the node enters the scene tree for the first time.
func _ready():
	self.isOutput = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

func update_signal_value():
	if self.wires:
		self.set_signal_value(self.wires[0].signal_value)
	else:
		self.interact_mesh.set_surface_override_material (0, signal_null_material)
