extends "res://scripts/Player.gd"

@export_group("Nodes")
@export var karnaugh_machine: KarnaughMachine

#var selected_group_id: int = 0:
	#set(value):
		#selected_group_id = value
		#%Level1UI.color_group = selected_group_id

func _input(event):
	super(event)
	
	if event.is_action_pressed("ConfirmSelection"):
		karnaugh_machine.add_new_island()
		_on_interact_raycast_cell_updated()

func _on_interact_raycast_cell_updated():
	$CameraHolder/Level1UI.group_count = karnaugh_machine.player_islands.size()
	$CameraHolder/Level1UI.selection_count = karnaugh_machine.cell_selection.size()
	
