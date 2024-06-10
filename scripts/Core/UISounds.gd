extends Node

@export var root_path : NodePath

@onready var sounds = {
	&"UI_Hover" : AudioStreamPlayer.new(),
	&"UI_Select" : AudioStreamPlayer.new(),
}

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(root_path != null, "Empty root path for UI sounds!")
	
	# set up audio stream players and load sound files
	for i in sounds.keys():
		sounds[i].stream = load("res://assets/audio/" + str(i) + ".ogg")
		#assign output mixer bus
		sounds[i].bus = &"UI"
		#add the stream players to the tree
		add_child(sounds[i])
		
	# recursively connect signals to all elements that should play sounds
	install_sounds(get_node(root_path))
	
func install_sounds(node: Node):
	for i in node.get_children():
		if i is Button:
			i.mouse_entered.connect(ui_sfx_play.bind(&"UI_Hover"))
			i.pressed.connect(ui_sfx_play.bind(&"UI_Select"))
			
		# then do it for all its children
		install_sounds(i)

func ui_sfx_play(sound: StringName):
	sounds[sound].play()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
