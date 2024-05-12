extends Control

const GROUP_COLORS = [
	Color("FF6666"),
	Color("ECA65E"),
	Color("DFD774"),
	Color("B1D16B"),
	Color("3EC2EE"),
	Color("6666FF"),
	Color("C266A3"),
	Color("C2A3A3"),
	]

var color_group: int = 0:
	set(value):
		color_group = value
		$HBoxContainer/ColorRect.color = GROUP_COLORS[color_group]
		
func _ready():
	color_group = 0
