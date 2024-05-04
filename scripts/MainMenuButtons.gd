extends VBoxContainer

@export var sceneToLoad : PackedScene

func _on_play_button_pressed():
	get_tree().change_scene_to_packed(sceneToLoad)


func _on_exit_button_pressed():
	get_tree().quit()


func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Settings_Menu.tscn")
