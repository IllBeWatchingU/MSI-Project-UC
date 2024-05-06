extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.4 # TODO: Export this

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") #9.8 lmao

@onready var CameraHolder: Node3D = $CameraHolder

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event):
	if event.is_action_pressed("Quit"): 
		get_tree().quit()
		
	if event is InputEventMouseMotion:
		var horzRot = event.relative.x * -SENSITIVITY
		#Clamp to not invert camera
		var vertRot = event.relative.y * -SENSITIVITY
		
		#Rotate entire player so they move in facing direction
		rotate_y(deg_to_rad(horzRot))
		#Rotate just the view so they can look up/down
		CameraHolder.rotate_x(deg_to_rad(vertRot))
		CameraHolder.rotation_degrees.x = clamp(CameraHolder.rotation_degrees.x, -90, 90)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("MoveLeft", "MoveRight", "MoveForward", "MoveBack")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
