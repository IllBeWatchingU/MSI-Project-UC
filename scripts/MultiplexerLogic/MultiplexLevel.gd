extends Node3D

var game_complete : bool = false

var multiplexers = []

var correct_result = {
	"number_of_multiplexers" : 1,
	"m1_i0" : -1,
	"m1_i1" : 0,
	"m1_i2" : 0,
	"m1_i3": 0,
	"m1_i4" : 0,
	"m1_i5" : 0,
	"m1_i6": 0,
	"m1_i7" : 0,
	"m1_a0" : 0,
	"m1_a1" : 0,
	"m1_a2" : 0,
	"m2_i0" : 0,
	"m2_i1": 0,
	"m2_i2" : 0,
	"m2_i3": 0,
	"m2_i4" : 0,
	"m2_i5": 0,
	"m2_i6": 0,
	"m2_i7": 0,
	"m2_a0" : 0,
	"m2_a1" : 0,
	"m2_a2" : 0,
	"m3_i0" : 0,
	"m3_i1": 0,
	"m3_i2" : 0,
	"m3_i3": 0,
	"m3_i4" : 0,
	"m3_i5": 0,
	"m3_i6": 0,
	"m3_i7": 0,
	"m3_a0" : 0,
	"m3_a1" : 0,
	"m3_a2" : 0,
}

@onready var no_mpx_label = $NumberMultiplexers as Label3D
@onready var result_label = $Deco/Display/Result as Label3D
@onready var result_button = $ResultButton as Interactable


func check_result():
	var number_of_mpx = int(no_mpx_label.text)
	if number_of_mpx == correct_result.number_of_multiplexers:
		multiplexers = get_multiplexers(number_of_mpx)
		for i in number_of_mpx:
			for j in 7:
				var dict_name = "m" + str(i+1) + "_i" + str(j)
				if multiplexers[i].get_register(j) != correct_result[dict_name] && correct_result[dict_name] != -1:
					result_label.text = "Wrong!"
					return
				
			for j in 2:
				var dict_name = "m" + str(i+1) + "_a" + str(j)
				if multiplexers[i].get_selector(j) != correct_result[dict_name]:
					result_label.text = "Wrong!"
					return
		result_label.text = "Good!"
	else: 
		result_label.text = "Wrong!"
		
func get_multiplexers(num : int):
	multiplexers = []
	if num == 1:
		multiplexers.append($NumberMultiplexers/SingleMpx/Mpx1/Multiplexer)
	elif num == 2:
		multiplexers.append($NumberMultiplexers/TwoMpx/Mpx1/Multiplexer)
		multiplexers.append($NumberMultiplexers/TwoMpx/Mpx2/Multiplexer)
		
	return multiplexers

func _on_result_button_pressed(_interactor):
	check_result()

# Called when the node enters the scene tree for the first time.
func _ready():
	result_button.interacted.connect(_on_result_button_pressed)
	
	#print(multiplexers)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
