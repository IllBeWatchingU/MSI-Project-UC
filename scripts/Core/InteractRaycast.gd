class_name InteractRaycast
extends RayCast3D

signal cell_updated

@onready var interact_key = InputMap.action_get_events("Interact")[0].as_text_physical_keycode()

var last_collided: Object = null 
	
func _physics_process(_delta):
	var body: Node3D = get_collider()
	
	if not is_instance_valid(last_collided):
		last_collided = null
	
	if last_collided != body:
		if last_collided is Interactable: 
			last_collided.unfocused.emit(self)
			$Label.text = ""
		if body is Interactable: 
			body.focused.emit(self)
			$Label.text = "%s\n[%s] %s" % [body.display_text, interact_key, body.action_text]
	last_collided = body
		

func _input(event):
	if event.is_action_pressed("Interact") and last_collided is Interactable:
		last_collided.interacted.emit(self)
		

