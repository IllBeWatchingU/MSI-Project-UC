extends Interactable

enum POSSIBLE_KEYS {
	NONE = KEY_0,
	A = KEY_A,
	B = KEY_B,
	C = KEY_C,
	D = KEY_D,
	}

signal pressed(letter: Key)
@export var letter: POSSIBLE_KEYS = POSSIBLE_KEYS.NONE
# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = OS.get_keycode_string(letter as Key)

	
func _on_interacted(_interactor: InteractRaycast):
	pressed.emit(letter)
