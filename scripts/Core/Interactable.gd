class_name Interactable
extends StaticBody3D

signal focused(interactor: RayCast3D)
signal unfocused(interactor: RayCast3D)
signal interacted(interactor: RayCast3D)

@export var display_text: String = ""
@export var action_text: String = ""

@onready var interact_mesh = find_child("InteractMesh")
@onready var highlight_material: Material = preload("res://assets/highlight_material.tres")

func _on_focused(_interactor):
	interact_mesh.material_overlay = highlight_material


func _on_interacted(_interactor):
	pass


func _on_unfocused(_interactor):
	interact_mesh.material_overlay = null
