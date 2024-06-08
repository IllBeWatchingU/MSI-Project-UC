extends Interactable

signal reset_pressed()

func _on_interacted(_interactor):
	reset_pressed.emit()
