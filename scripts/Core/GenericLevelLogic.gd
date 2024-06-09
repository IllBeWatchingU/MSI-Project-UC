class_name GenericLevelLogic
extends Node3D

@onready var player : Player = $Player
@export var levelName : String

func game_complete():
	player.game_completed(levelName)
