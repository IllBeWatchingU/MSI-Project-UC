extends Label3D

var old_text : String

# Called when the node enters the scene tree for the first time.
func _ready():
	old_text = self.text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(old_text != self.text):
		old_text = self.text
		var value = old_text.to_int()
		var stages = self.get_children()
		if value == 1:
			stages[0].visible = true
			stages[1].visible = false
		elif value == 2:
			stages[1].visible = true
			if stages[0].visible:
				stages[0].visible = false
			elif stages[2].visible:
				stages[2].visible = false
		elif value == 3:
			stages[2].visible = true
			stages[1].visible = false
