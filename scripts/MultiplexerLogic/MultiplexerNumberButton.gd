extends Interactable

@export var mode : int
@export var number_of_multiplexers : Label3D

func _on_interacted(_interactor):
	if mode == 1:
		#add a multiplexer
		var new_number = number_of_multiplexers.text.to_int() + 1
		if new_number <= 3:
			number_of_multiplexers.text = str(new_number)
	elif mode == 0:
		var new_number = number_of_multiplexers.text.to_int() - 1
		if new_number > 0:
			number_of_multiplexers.text = str(new_number)
