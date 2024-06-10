extends StaticBody3D
class_name KarnaughMachine

signal level_won()

const State = Constants.State

@export var generate_dont_cares: bool = false

@export_group("Nodes")
@export var reset_button: Node3D
@export var input_display: Display
@export var output_machine: OutputMachine

var cell_values: Array[State]
var player_islands: Array[Island]
var min_islands: Array[Island]
var min_function: String

var instanciated_island_markers: Array[IslandMarker] 

var cell_selection: Array[int]:
	get: #Call each cell and check selected
		var result: Array[int] = []
		for i in range(16):
			var cell = get_cell_by_id(i)
			if(cell.selected): result.append(i)
		return result
		
class Island:
	enum letr {
		A = 0x80, AN = 0x40,
		B = 0x20, BN = 0x10,
		C = 0x08, CN = 0x04,
		D = 0x02, DN = 0x01,
	}
	
	const ROWS = [letr.AN | letr.BN, letr.AN | letr.B, letr.A | letr.B, letr.A | letr.BN]
	const COLS = [letr.CN | letr.DN, letr.CN | letr.D, letr.C | letr.D, letr.C | letr.DN]
	
	var start: Vector2i
	var shape: Vector2i
	
	var end: Vector2i:
		get: return (start + shape - Vector2i.ONE) % 4
	var size: int:
		get: return shape.x * shape.y
	var bitmap: int:
		get: 
			var map = 0
			for i in range(shape.x):
				for j in range(shape.y):
					map |= 1 << Cell.xy2id((start + Vector2i(i,j)) % 4)
			return map
	var function: String:
		get:
			#  _ _ _ _
			# AABBCCDD bitmap format.
			var func_bmap := 0
			
			# Turn on every flag required by function
			for i in range(shape.x):
				for j in range(shape.y):
					func_bmap |= COLS[(start.x + i) % 4] | ROWS[(start.y + j) % 4]
			
			# Remove cancelled out flags (eg. A and AN)
			for i in range(4):
				var mask = 0b11 << i*2
				if func_bmap & mask == mask: func_bmap -= mask
			
			# Generate string
			var result = ""
			for flag in letr.values():
				if func_bmap & flag:
					result += "%s" % letr.find_key(flag)
			
			return result.replace("N", String.chr(0x0304))
	var corners: Array[Vector2i]:
		get:
			var result: Array[Vector2i] = []
			result.append(start)
			result.append((start + (shape - Vector2i.ONE) * Vector2i.RIGHT) % 4)
			result.append(end)
			result.append((start + (shape - Vector2i.ONE) * Vector2i.DOWN) % 4)
			return result
	
	static func fromFunction(f: String) -> Island:
		var letters := []
		for c in f:
			if c != String.chr(0x0304):
				letters.append(c)
			else:
				letters[-1] = letters[-1] + "N"
		
		var bits = letters.map(func(x): return letr.get(x))
		var mask = bits.reduce(func(acc, val): return acc | val, 0)
		var list: Array[int] = []
		
		for i in range(16):
			if (COLS[i % 4] | ROWS[i / floor(4)]) & mask == mask:
				list.append(i)
		
		return Island.fromList(list)
		
	static func fromList(list: Array[int]) -> Island:
		var result = null
		if Constants.ISLAND_SIZES.has(list.size()):
			for cell_id in list:
				var st = Cell.id2xy(cell_id)
				for sh in Constants.ISLAND_CONFIGURATIONS[list.size()]:
					var temp = Island.tryFromStartList(st, sh, list)
					result = temp if temp else result
		
		return result
	
	static func tryFromStartList(st: Vector2i, sh: Vector2i, list: Array[int]) -> Island:
		for x in sh.x:
			for y in sh.y:
				var v := (st + Vector2i(x,y)) % 4
				if not list.has(Cell.xy2id(v)): return null
		return Island.new(st, sh).normalized()
	
	func _init(p_start: Vector2i, p_shape: Vector2i):
		self.start = p_start
		self.shape = p_shape

	func _to_string():
		return "Island %s at %s" % [shape, start]
		
	func contains(other: Island) -> bool:
		return bitmap & other.bitmap == other.bitmap
	
	func adds_anything_new(islands: Array[Island], without_self: bool = false) -> bool:
		var copy = islands.duplicate()
		if without_self:
			copy.erase(self)
		
		var island_map := 0
		for island in copy:
			island_map |= island.bitmap
		return island_map | bitmap != island_map
	
	func normalized() -> Island:
		var new_start := start
		for i in range(2):
			if shape[i] == 4:
				new_start[i] = 0
		return Island.new(new_start, shape)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	reset_button.get_node("Button").reset_pressed.connect(randomize_input)
	
	randomize_input()

func randomize_input():
	for marker in instanciated_island_markers:
		marker.queue_free()
	player_islands = []
	min_islands = []
	min_function = ""
	instanciated_island_markers = []
	deselect_all()
	
	
	cell_values = []
	var table = [State.OFF, State.ON]
	if generate_dont_cares: table.append(State.IGNORE)
	for i in range(16):
		cell_values.append(table[randi() % table.size()])
		get_node("Cells/Cell%s" % i).state = cell_values[i]
	
	input_display.set_input_string(cell_values)
	output_machine.reset()
	
	solve()
	
func add_new_island() -> void:
	# Verify we selected the right number of cells
	var size := cell_selection.size()
	if Constants.ISLAND_SIZES.has(size):
		var island: Island = null
		for id in cell_selection:
			var cell := get_cell_by_id(id)
			for shape in Constants.ISLAND_CONFIGURATIONS[size]:
				#Check if cell is top right corner of island
				var isl := get_valid_shape(cell.grid_pos, shape, true)
				island = isl if isl else island
		
		if island:
			player_islands.append(island)
			for i in range(4):
				var cell = get_cell_by_xy(island.corners[i])
				var marker = IslandMarker.spawn(i, player_islands.size() - 1)
				cell.add_child(marker)
				instanciated_island_markers.append(marker)
		
	deselect_all()

func get_valid_shape(start: Vector2i, shape: Vector2i, check_selected: bool = false) -> Island:
		var check: Callable
		if check_selected:
			check = func(cell: Cell): return cell.selected
		else:
			check = func(cell: Cell): return cell.state == State.ON

		for x in shape.x:
			for y in shape.y:
				var v := (start + Vector2i(x,y)) % 4
				if not check.call(get_cell_by_xy(v)): return null
		return Island.new(start, shape).normalized()
				
func deselect_all() -> void:
	for id in cell_selection:
		get_cell_by_id(id).selected = false

#region Solvers
func solve() -> void:
	# Get all possible islands
	for i in range(16):
		var new_islands := find_islands(get_cell_by_id(i))
		min_islands.append_array(new_islands)

	# Sort them by size
	min_islands.sort_custom(func(a: Island, b:Island): 
		return true if a.size > b.size else false
	)
	
	# Remove islands that are fully covered by bigger islands
	min_islands = min_islands.reduce(
		func(acc: Array[Island], val: Island):
			if val.adds_anything_new(acc):
				acc.append(val)
			return acc, 
		[] as Array[Island])
	
	# Remove islands that are fully covered by [all islands without this one]
	min_islands = min_islands.filter(func(x: Island): return x.adds_anything_new(min_islands, true))
	
	for island in min_islands:
		min_function += "%s + " % island.function
	
	min_function = min_function.left(-3)
	
func find_islands(cell: Cell) -> Array[Island]:
	#Island1
	var width := clip_to_dim(find_width(cell))
	var height := clip_to_dim(extend_down(cell, width))
	var island1 := Island.new(cell.grid_pos, Vector2i(width, height))
	#Island2
	height = clip_to_dim(find_height(cell))
	width = clip_to_dim(extend_right(cell, height))
	var island2 := Island.new(cell.grid_pos, Vector2i(width, height))
	
	var ret: Array[Island] = []
	if(island1.shape != Vector2i.ZERO): ret.append(island1)
	if(island2.shape != Vector2i.ZERO and island2.shape != island1.shape): ret.append(island2)
	
	return ret

func find_width(cell: Cell) -> int:
	if cell.state == State.OFF: return 0
	else:
		var w := 1
		var next_cell := cell.right
		while next_cell != cell and next_cell.state != State.OFF:
			w += 1
			next_cell = next_cell.right
		return w
		
func find_height(cell: Cell) -> int:
	if cell.state == State.OFF: return 0
	else:
		var w := 1
		var next_cell := cell.down
		while next_cell != cell and next_cell.state != State.OFF:
			w += 1
			next_cell = next_cell.down
		return w

func extend_down(cell: Cell, width: int) -> int:
	if(width == 0): return 0
	var height := 1
	var next_cell := cell.down
	while next_cell != cell and next_cell.state != State.OFF:
		if(find_width(next_cell) >= width):
			height += 1
			next_cell = next_cell.down
		else: break
	return height
	
func extend_right(cell: Cell, height: int) -> int:
	if(height == 0): return 0
	var width := 1
	var next_cell := cell.right
	while next_cell != cell and next_cell.state != State.OFF:
		if(find_height(next_cell) >= height):
			width += 1
			next_cell = next_cell.right
		else: break
	return width

func clip_to_dim(d: int) -> int:
	var r := 0
	for d2 in Constants.ISLAND_DIMS:
		if d >= d2: r = d2
		else: break
	return r
	
func check_answer(answer: String) -> bool:
	var functions := Array(answer.split(" + "))
	var islands := functions.map(func(x): return Island.fromFunction(x))
	
	if (islands.size() != min_islands.size()): return false
	
	var f = func(acc: int, val: Island): return acc | val.bitmap
		
	var map = islands.reduce(f, 0)
	var map_min = min_islands.reduce(f, 0)
	
	return map == map_min

#endregion Solver

#region Helpers
func get_cell_by_xy(v: Vector2i) -> Cell:
	var id := Cell.xy2id(v)
	return get_cell_by_id(id)
	
	
func get_cell_by_id(id: int) -> Cell:
	return get_node("Cells/Cell%s" % id)
	

static func bin2gray(v: int) -> int:
	return v ^ (v >> 1)


static func gray2bin(v: int) -> int:
	var mask := v
	var res := v
	while(mask):
		mask >>= 1
		res ^= mask
	return res


#endregion

func spawn_answer() -> void:
	for island_id in range(min_islands.size()):
		for i in range(4):
			var island = min_islands[island_id]
			var cell = get_cell_by_xy(island.corners[i])
			var marker = IslandMarker.spawn(i, -island_id-1)
			cell.add_child(marker)
			instanciated_island_markers.append(marker)

func _on_output_machine_confirmed(result):
	output_machine.enabled = false
	print(min_function)
	if check_answer(result):
		output_machine.set_text("You did it!")
		level_won.emit()
	else:
		output_machine.set_text("Wrong answer!\nCorrect answer is:\n" + min_function)
		spawn_answer()
