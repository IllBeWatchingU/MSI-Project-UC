extends Control

var center : Vector2
@onready var node = $Control

# Called when the node enters the scene tree for the first time.
func _ready():
	center = Vector2(get_viewport_rect().size.x/2, get_viewport_rect().size.y/2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var tween = node.create_tween()
	var offset = center - get_global_mouse_position() * 0.1
	tween.tween_property(node,"position",offset,1.0)


func _on_item_rect_changed():
	center = Vector2(get_viewport_rect().size.x/2, get_viewport_rect().size.y/2)
	if node != null:
		node.global_position = center
