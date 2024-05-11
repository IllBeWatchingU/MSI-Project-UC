extends "res://scripts/Interactable.gd"

signal reset_pressed()

func _on_interacted(_interactor):
	reset_pressed.emit()
