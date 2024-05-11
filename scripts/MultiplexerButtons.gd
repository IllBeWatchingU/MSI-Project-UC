class_name MultiplexerButtonsInteractable
extends Interactable

@export var value : Label3D

func _on_interacted(_interactor):
	if value.text == "0":
		value.text = "1"
	else:
		value.text = "0"
