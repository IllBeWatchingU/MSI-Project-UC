extends Control

var color_group: int = 0:
	set(value):
		color_group = value
		$HBoxContainer/ColorRect.color = Constants.GROUP_COLORS[color_group]
		
func _ready():
	color_group = 0
