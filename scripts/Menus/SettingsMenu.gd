class_name SettingsMenu
extends Control

@onready var exit_button = $TextureRect/MarginContainer/VBoxContainer/ExitButton as Button

signal exit_options_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	exit_button.button_down.connect(on_exit_pressed)
	set_process(false)
	
func on_exit_pressed():
	exit_options_menu.emit()
	set_process(false)

