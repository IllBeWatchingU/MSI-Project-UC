extends Node

enum State {OFF, ON, IGNORE}

const GROUP_COUNT = 8
const GROUP_COLORS = [
	Color("FF6666"),
	Color("ECA65E"),
	Color("DFD774"),
	Color("B1D16B"),
	Color("3EC2EE"),
	Color("6666FF"),
	Color("C266A3"),
	Color("C2A3A3"),
	]

const ISLAND_CONFIGURATIONS = {
	1: [Vector2i(1, 1)],
	2: [Vector2i(1, 2), Vector2i(2, 1)],
	4: [Vector2i(4, 1), Vector2i(2, 2), Vector2i(1, 4)],
	8: [Vector2i(4, 2), Vector2i(2, 4)],
	16: [Vector2i(4, 4)]
}

