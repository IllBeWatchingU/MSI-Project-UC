extends Control

var center : Vector2
@onready var node = $Control
@onready var play_button = $AudioNode/MarginContainer/HBoxContainer/Buttons/PlayButton as Button
@onready var settings_button = $AudioNode/MarginContainer/HBoxContainer/Buttons/SettingsButton as Button
@onready var exit_button = $AudioNode/MarginContainer/HBoxContainer/Buttons/ExitButton as Button
@onready var leaderboard_button = $AudioNode/MarginContainer/HBoxContainer/Buttons/LeaderboardButton as Button
@onready var settings_menu = $AudioNode/SettingsMenu as SettingsMenu
@onready var level_menu = $AudioNode/LevelSelectMenu as LevelSelectMenu
@onready var leaderboard_menu = $AudioNode/LeaderboardMenu as LeaderboardMenu
@onready var margin_container = $AudioNode/MarginContainer as MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	center = Vector2(get_viewport_rect().size.x/2, get_viewport_rect().size.y/2)
	
	play_button.button_down.connect(_on_play_button_pressed)
	settings_button.button_down.connect(_on_settings_button_pressed)
	exit_button.button_down.connect(_on_exit_button_pressed)
	leaderboard_button.button_down.connect(_on_leaderboard_button_pressed)
	
	settings_menu.exit_options_menu.connect(_on_exit_options_menu)
	level_menu.exit_levels_menu.connect(_on_exit_level_menu)
	leaderboard_menu.exit_leaderboard_menu.connect(_on_exit_leaderboard_menu)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var tween = node.create_tween()
	var offset = center - get_global_mouse_position() * 0.1
	tween.tween_property(node,"position",offset,1.0)

func _on_item_rect_changed():
	center = Vector2(get_viewport_rect().size.x/2, get_viewport_rect().size.y/2)
	if node != null:
		node.global_position = center
		
func _on_play_button_pressed():
	margin_container.visible = false
	level_menu.set_process(true)
	level_menu.visible = true

func _on_settings_button_pressed():
	margin_container.visible = false
	settings_menu.set_process(true)
	settings_menu.visible = true
	
func _on_leaderboard_button_pressed():
	margin_container.visible = false
	leaderboard_menu.set_process(true)
	leaderboard_menu.visible = true

func _on_exit_button_pressed():
	get_tree().quit()
	
func _on_exit_options_menu():
	margin_container.visible = true
	settings_menu.visible = false
	
func _on_exit_level_menu():
	margin_container.visible = true
	level_menu.visible = false
	
func _on_exit_leaderboard_menu():
	margin_container.visible = true
	leaderboard_menu.visible = false

