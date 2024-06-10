extends Control

@onready var confirm_key = InputMap.action_get_events("ConfirmSelection")[0].as_text_physical_keycode()

var group_count: int = 0:
	set(value): # Update label
		group_count = value
		$VBoxContainer/GroupLabel.text = "Groups Created: %d" % group_count
var selection_count: int = 0:
	set(value): # Update label
		selection_count = value
		$VBoxContainer/SelectionLabel.text = "Cells Selected: %d" % selection_count

		
func _ready():
	$VBoxContainer/ConfirmKeyLabel.text = "Press '%s' to confirm selection" % confirm_key
	
func _process(_delta):
	$VBoxContainer/FpsLabel.text = "Frames: %d" % Engine.get_frames_per_second()
