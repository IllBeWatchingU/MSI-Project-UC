extends GateOutlet

signal bit_change

# Called when the node enters the scene tree for the first time.
func _ready():
	self.isOutput = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self.wire:
		var prev_signal_value = self.signal_value
		self.signal_value = self.wire.signal_value
		if prev_signal_value != self.signal_value:
			bit_change.emit()
