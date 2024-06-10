extends Interactable

signal pressed()
@export var label_text: String
# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = label_text

	
func _on_interacted(_interactor: InteractRaycast):
	pressed.emit()
