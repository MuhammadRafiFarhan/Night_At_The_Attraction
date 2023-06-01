extends Control

#monitoring power usage

onready var game = get_tree().get_root().get_node("Game")
onready var label = $MarginContainer/HBoxContainer/VBoxContainer/Label

const USAGE_MULTIPLIER = 0.2

var power_left = 100
var total_usage = 0

signal out_of_power

func _process(delta):
	total_usage = int(game.left_door_closed) + int(game.right_door_closed) + int(game.left_light_on) + int(game.right_light_on) + int(game.cameras_on)
	power_left -= delta * total_usage * USAGE_MULTIPLIER
	
	label.text = str(int(power_left)) + "%"
	if int(power_left) <= 0:
		emit_signal("out_of_power")
		set_process(false)
		hide()
