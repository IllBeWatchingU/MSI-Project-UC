extends GenericLevelLogic


const INPUT_ARR = [[false, false], [false, true], [true, false], [true, true]]
const OR_TRUTH_TABLE = [false, true, true, true]
const AND_TRUTH_TABLE = [false, false, false, true]
const XOR_TRUTH_TABLE = [false, true, true, false]
const NOR_TRUTH_TABLE = [true, false, false, false]
const TRUTH_TABLES = [OR_TRUTH_TABLE, AND_TRUTH_TABLE, XOR_TRUTH_TABLE, NOR_TRUTH_TABLE]
const GATE_NAMES = {
	OR_TRUTH_TABLE: "OR GATE",
	AND_TRUTH_TABLE: "AND GATE",
	XOR_TRUTH_TABLE: "XOR GATE",
	NOR_TRUTH_TABLE: "NOR GATE"
}

var rng = RandomNumberGenerator.new()
var CURRENT_TRUTH_TABLE


func _ready():
	CURRENT_TRUTH_TABLE = TRUTH_TABLES[rng.randi_range(0, TRUTH_TABLES.size() - 1)]
	var level_label = find_child("Player").find_child("CameraHolder").find_child("Level2UI").find_child("CenterContainer").find_child("Label")
	level_label.text = "TASK: " + GATE_NAMES[CURRENT_TRUTH_TABLE]
	

func game_complete_check():
	var board = find_child("Board")
	var input_a = board.find_child("BoardInputA").find_child("Outlet")
	var input_b = board.find_child("BoardInputB").find_child("Outlet")
	var output = board.find_child("BoardOutput").find_child("Inlet")
	var success = true
	
	for i in range(self.INPUT_ARR.size()):
		input_a.set_signal_value(INPUT_ARR[i][0])
		input_b.set_signal_value(INPUT_ARR[i][1])
	
		if output.signal_value != self.CURRENT_TRUTH_TABLE[i]:
			success = false
	
	if success:
		game_complete()
