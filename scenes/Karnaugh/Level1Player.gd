extends "res://scripts/Player.gd"

const GROUP_COUNT = 8

var selected_group_id: int = 0:
	set(value):
		print(value)
		selected_group_id = value
		%Level1UI.color_group = selected_group_id

func _input(event):
	super(event)
	
	if event.is_action_pressed("CycleItemUp"):
		selected_group_id = posmod(selected_group_id + 1, GROUP_COUNT)
	if event.is_action_pressed("CycleItemDown"):
		selected_group_id = posmod(selected_group_id - 1, GROUP_COUNT)
