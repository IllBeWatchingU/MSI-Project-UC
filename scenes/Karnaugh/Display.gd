extends StaticBody3D
class_name Display

const State := KarnaughMachine.State

@export var label_text: String:
	set(s):
		label_text = s
		$Label3D.text = label_text

func set_input_string(input: Array[State]):
	var args := ""
	var x_args := ""
	for i in range(16):
		match input[KarnaughMachine.gray2bin(i)]:
			State.ON: args += "%d, " % i
			State.IGNORE: x_args += "%d, " % i
	#remove trailing comma and
	#add parenthesis for don't cares
	if x_args != "":
		x_args = x_args.left(-2)
		x_args = "(%s)" % x_args
	else: 
		args = args.left(-2)
			
	label_text = "f(a,b,c,d) = Σ(%s%s)" % [args, x_args]
