extends RayCast3D

var last_collided: Object = null 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
	
func _physics_process(_delta):
	var body: Node3D = get_collider()
	
	if last_collided == body: return
	if last_collided is Interactable: last_collided.unfocused.emit(self)
	if body is Interactable: body.focused.emit(self)
	last_collided = body
		

func _input(event):
	if event.is_action_pressed("Interact") and last_collided is Interactable:
		last_collided.interacted.emit(self)
		

