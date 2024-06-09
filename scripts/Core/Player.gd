class_name Player
extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.4 

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") #9.8 lmao

@onready var CameraHolder: Node3D = $CameraHolder
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var timer : Label = $CameraHolder/TimerContainer/Label
@onready var timerLogic : TimerLogic = $TimerLogic
@onready var gameCompleteMenu : GameCompleteMenu = $CameraHolder/GameCompleteMenu

var is_game_complete : bool = false 

func game_completed(levelName : String):
	var score : String = timerLogic.get_time()
	is_game_complete = true
	gameCompleteMenu.set_score(score)
	SaveManager.save_current_score(levelName, score)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	gameCompleteMenu.set_process(true)
	gameCompleteMenu.visible = true

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	gameCompleteMenu.reset_level.connect(timerLogic.reset)
	
func _input(event):
	if !is_game_complete:
		if event.is_action_pressed("Quit"): 
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			get_tree().change_scene_to_file("res://scenes/Menus/MainMenu.tscn")
			
		if event is InputEventMouseMotion:
			var horzRot = event.relative.x * -SENSITIVITY
			#Clamp to not invert camera
			var vertRot = event.relative.y * -SENSITIVITY
			
			#Rotate entire player so they move in facing direction
			rotate_y(deg_to_rad(horzRot))
			#Rotate just the view so they can look up/down
			CameraHolder.rotate_x(deg_to_rad(vertRot))
			CameraHolder.rotation_degrees.x = clamp(CameraHolder.rotation_degrees.x, -90, 90)
			
		if event.is_action_pressed("Reset"):
			timerLogic.reset()

func _process(_delta):
	if(!is_game_complete):
		timer.text = timerLogic.get_time()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		audio_player.play()

	var input_dir = Input.get_vector("MoveLeft", "MoveRight", "MoveForward", "MoveBack")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
