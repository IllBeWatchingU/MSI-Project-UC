extends Node3D
class_name OutputMachine

signal confirmed(result: String)

@export var enabled: bool = true

enum BUTTONS {
	LETTER,
	PLUS,
	NEGATE,
	CONFIRM,
	BACK,
}

var result_string: String:
	set(value):
		if enabled:
			result_string = value
			$Display.label_text = "Answer: %s" % result_string
var prev_button: BUTTONS = BUTTONS.BACK:
	set(value):
		if enabled:
			prev_button = value
		
func _ready():
	result_string = ""
	
func reset():
	enabled = true
	result_string = ""
	prev_button = BUTTONS.BACK

func set_text(text: String):
	$Display.label_text = text

func _on_letter_button_pressed(letter: Key):
	result_string += OS.get_keycode_string(letter)
	prev_button = BUTTONS.LETTER


func _on_back_button_pressed():
	match prev_button:
		BUTTONS.LETTER:
			result_string = result_string.left(-1)
		BUTTONS.NEGATE:
			result_string = result_string.left(-2)
		BUTTONS.PLUS:
			result_string = result_string.left(-3)
	
	match result_string.right(1):
		" ": prev_button = BUTTONS.PLUS
		"A","B","C","D": prev_button = BUTTONS.LETTER
		"̄": prev_button = BUTTONS.NEGATE #Thats a fucking macron stuck to a string lmao
		

func _on_negate_button_pressed():
	match prev_button:
		BUTTONS.LETTER:
			result_string += String.chr(0x0304)
			prev_button = BUTTONS.NEGATE
		BUTTONS.NEGATE:
			result_string = result_string.left(-1)
			prev_button = BUTTONS.LETTER


func _on_confirm_button_pressed():
	confirmed.emit(result_string)
	#prev_button = BUTTONS.CONFIRM


func _on_plus_button_pressed():
	result_string += " + "
	prev_button = BUTTONS.PLUS
