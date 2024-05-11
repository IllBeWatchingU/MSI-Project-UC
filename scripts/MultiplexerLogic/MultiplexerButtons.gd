class_name MultiplexerButtonsInteractable
extends Interactable

@export var value : Label3D

func _on_interacted(_interactor):
	if value.text == "0":
		value.text = "1"
	elif value.text == "1":
		value.text = "0"
