class_name LevelSelectMenu
extends Control

@onready var level1_button = $MarginContainer/VBoxContainer/HBoxContainer/Buttons/Level1Button as Button
@onready var level2_button = $MarginContainer/VBoxContainer/HBoxContainer/Buttons/Level2Button as Button
@onready var level3_button = $MarginContainer/VBoxContainer/HBoxContainer/Buttons/Level3Button as Button
@onready var exit_button = $MarginContainer/VBoxContainer/HBoxContainer/Buttons/ExitButton as Button

@export var level1Scene : PackedScene
@export var level2Scene : PackedScene
@export var level3Scene : PackedScene

signal exit_levels_menu

func _ready():
	level1_button.button_down.connect(_on_level_1_pressed)
	level2_button.button_down.connect(_on_level_2_pressed)
	level3_button.button_down.connect(_on_level_3_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	set_process(false)
	
func on_exit_pressed():
	exit_levels_menu.emit()
	set_process(false)

func _on_level_1_pressed():
	get_tree().change_scene_to_packed(level1Scene)


func _on_level_2_pressed():
	get_tree().change_scene_to_packed(level2Scene)


func _on_level_3_pressed():
	get_tree().change_scene_to_packed(level3Scene)
