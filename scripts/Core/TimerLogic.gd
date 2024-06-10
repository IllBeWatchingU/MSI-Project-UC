class_name TimerLogic
extends Node

@onready var game_start_time = Time.get_ticks_msec()

func reset():
	get_tree().reload_current_scene()
	game_start_time = Time.get_ticks_msec()

func get_time():
	var current_time = Time.get_ticks_msec() - game_start_time
	var minutes = current_time / floor(1000) / floor(60)
	var seconds = current_time / floor(1000) % 60
	var mseconds = current_time % floor(100)
	if minutes < 10:
		minutes = "0" + str(minutes)
	if seconds < 10:
		seconds = "0" + str(seconds)
	if mseconds < 10:
		mseconds = "0" + str(mseconds)
	return (str(minutes) + ":" + str(seconds) + ":" + str(mseconds))
