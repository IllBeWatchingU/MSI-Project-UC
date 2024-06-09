extends HBoxContainer

@onready var save_button = $SaveButton as Button
@onready var line_edit = $LineEdit as LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	save_button.button_down.connect(_on_save_button_pressed)
	line_edit.text_changed.connect(_on_line_edit_changed)
	save_button.disabled = true

func _on_line_edit_changed(_text):
	if save_button.disabled:
		save_button.disabled = false

func _on_save_button_pressed():
	var data = SaveManager.read_save()
	data.current_player_name = line_edit.text
	SaveManager.write_save(data)
	save_button.disabled = true
