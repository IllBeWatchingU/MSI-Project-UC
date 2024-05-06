class_name Interactable
extends StaticBody3D

signal focused(interactor: RayCast3D)
signal unfocused(interactor: RayCast3D)
signal interacted(interactor: RayCast3D)

@onready var interacted_material: Material = $MeshInstance3D.mesh.material.duplicate()
@onready var focused_material: Material = $MeshInstance3D.mesh.material.duplicate()

func _ready():
	interacted_material.albedo_color = Color("0000ff")
	focused_material.albedo_color = Color("00ff00")


func _on_focused(_interactor):
	$MeshInstance3D.material_override = focused_material


func _on_interacted(_interactor):
	$MeshInstance3D.material_override = interacted_material


func _on_unfocused(_interactor):
	$MeshInstance3D.material_override = null
