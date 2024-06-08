extends VBoxContainer

@export var level1Scene : PackedScene
@export var level2Scene : PackedScene
@export var level3Scene : PackedScene

func _on_level_1_pressed():
	get_tree().change_scene_to_packed(level1Scene)


func _on_level_2_pressed():
	pass # Replace with function body.


func _on_level_3_pressed():
	get_tree().change_scene_to_packed(level3Scene)


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/Menus/MainMenu.tscn")
