class_name GameCompleteMenu
extends Control

@onready var reset_button : Button = $MarginContainer/PanelContainer/VBoxContainer/RestartButton
@onready var exit_button : Button = $MarginContainer/PanelContainer/VBoxContainer/ExitButton
@onready var score_label : Label = $MarginContainer/PanelContainer/VBoxContainer/ScoreLabel

signal reset_level

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_button.button_down.connect(_on_reset_button_pressed)
	exit_button.button_down.connect(_on_exit_button_pressed)
	set_process(false)
	
func set_score(score : String):
	score_label.text = "Current time: " + score

func _on_reset_button_pressed():
	reset_level.emit()
	
func _on_exit_button_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().change_scene_to_file("res://scenes/Menus/MainMenu.tscn")
