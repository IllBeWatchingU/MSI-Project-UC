extends GateOutlet


# Called when the node enters the scene tree for the first time.
func _ready():
	self.isOutput = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self.wire:
		self.signal_value = self.wire.signal_value
