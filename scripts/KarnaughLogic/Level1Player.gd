extends Player

@export_group("Nodes")
@export var karnaugh_machine: KarnaughMachine

func _input(event):
	super(event)
	
	if Input.is_action_just_pressed("ConfirmSelection"):
		karnaugh_machine.add_new_island()
		_on_interact_raycast_cell_updated()

#func _unhandled_key_input(event):
	#if event is InputEventKey and not event.is_pressed():
		#var typed_event = event as InputEventKey
		#var has_shift = typed_event.shift_pressed
		#var key_typed = PackedByteArray([typed_event.get_keycode_with_modifiers()]).get_string_from_utf8()
		#
		#match has_shift:
			#true:
				#print(key_typed)
			#false:
				#print(key_typed.to_lower())

func _on_interact_raycast_cell_updated():
	$CameraHolder/Level1UI.group_count = karnaugh_machine.player_islands.size()
	$CameraHolder/Level1UI.selection_count = karnaugh_machine.cell_selection.size()
	
