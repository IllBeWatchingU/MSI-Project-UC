@tool
extends Node

@onready var cell_scn = preload("res://scenes/Karnaugh/Cell.tscn")

@export var button: bool = false:
	set(value):
		button = false
		if value: run_tool()

func run_tool():
	for i in range(16):
		var cell = cell_scn.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
		var grid_x: int = i%4
		var grid_y: int = i/4
		cell.position = Vector3(-0.425 + grid_x * 0.45, 1.625 - grid_y * 0.45, 0)
		cell.id = bin2gray(i)
		cell.name = "Cell%s" % i
		$"../Cells".add_child(cell)
		cell.set_owner(get_tree().edited_scene_root)
		
func bin2gray(v: int) -> int:
	return v ^ (v >> 1)
