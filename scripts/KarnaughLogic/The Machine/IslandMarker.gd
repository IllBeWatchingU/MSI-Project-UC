extends StaticBody3D
class_name IslandMarker

@export var corner: Corner:
	set(value): # Rotate to correct rotation
		corner = value
		rotate_z(-PI/2 * value)
var color: Color:
	set(value): # Change out mesh
		color = value
		var color_material: Material = $Pivot/Arm1.mesh.material.duplicate()
		color_material.albedo_color = color
		$Pivot/Arm1.material_override = color_material
		$Pivot/Arm2.material_override = color_material
var island_id: int:
	set(value): # Set color and scale
		island_id = value
		color = Constants.GROUP_COLORS[value]
		scale *= Vector3(1 - .05 * value, 1 - .05 * value, 1.0)
		position.z += .001 * value
		
		

const scene: PackedScene = preload("res://scenes/Karnaugh/The Machine/IslandMarker.tscn")

static func spawn(p_corner: Corner, p_id: int) -> IslandMarker:
	var node = scene.instantiate()
	node.corner = p_corner
	node.island_id = p_id
	return node
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
