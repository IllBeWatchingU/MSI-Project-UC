extends Label3D

signal text_changed
var old_text : String

# Called when the node enters the scene tree for the first time.
func _ready():
	old_text = self.text
	print(old_text)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(old_text != self.text):
		old_text = self.text
		emit_signal("text_changed")
		print("Changed:" + old_text)
