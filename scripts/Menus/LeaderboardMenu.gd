class_name LeaderboardMenu
extends Control

@onready var exit_button = $MarginContainer/VBoxContainer/ExitButton as Button
@onready var level_1_label = $MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/FirstLevel as Label
@onready var level_2_label = $MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/SecondLevel as Label
@onready var level_3_label = $MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/ThirdLevel as Label

var labels = []

signal exit_leaderboard_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	exit_button.button_down.connect(on_exit_pressed)
	
	labels.append(level_1_label)
	labels.append(level_2_label)
	labels.append(level_3_label)
	
	#read high scores from save file
	read_leaderboard()
	
	set_process(false)


func on_exit_pressed():
	exit_leaderboard_menu.emit()
	set_process(false)

func read_leaderboard():
	var data = SaveManager.read_save()
	for i in data.high_scores.size():
		var row_name = "level_" + str(i+1)
		labels[i].text = data.high_scores[row_name].username + " " + data.high_scores[row_name].score 
