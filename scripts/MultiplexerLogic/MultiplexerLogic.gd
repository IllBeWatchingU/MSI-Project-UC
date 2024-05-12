extends StaticBody3D

var registers = Array()
var selectors = Array()
var Result : Label3D
var changed_label = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in self.get_node("MeshInstance3D").get_node("Inputs").get_children():
		registers.append(i)
		
	for i in self.get_node("MeshInstance3D").get_node("Selectors").get_children():
		selectors.append(i)
		
	Result = self.get_node("MeshInstance3D").get_node("Result")
	
	for a in registers:
		a.text_changed.connect(_on_text_changed)
		
	for a in selectors:
		a.text_changed.connect(_on_text_changed)
	
	#print(registers)
	#print(selectors)
	#print(Result.text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(changed_label):
		var idx = _compute_result()
		Result.text = registers[idx].text
		changed_label = 0

func _compute_result():
	var res = 0
	for a in range(selectors.size()):
		res += selectors[a].text.to_int() * (2 ** a)
		
	return res

func _on_text_changed():
	changed_label = 1

