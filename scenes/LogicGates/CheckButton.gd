extends Interactable

signal completed()
const INPUT_ARR = [[false, false], [false, true], [true, false], [true, true]]
const OR_GATE_TABLE = [false, true, true, true]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_interacted(interactor):
	var board = get_parent().get_parent().find_child("Board")
	var input_a = board.find_child("BoardInputA").find_child("Outlet")
	var input_b = board.find_child("BoardInputB").find_child("Outlet")
	var output = board.find_child("BoardOutput").find_child("Inlet")
	var success = true
	
	for i in range(self.INPUT_ARR.size()):
		input_a.signal_value = self.INPUT_ARR[i][0]
		input_b.signal_value = self.INPUT_ARR[i][1]
		
		if output.signal_value != self.OR_GATE_TABLE[i]:
			success = false
	if success:
		$"../..".game_complete()
