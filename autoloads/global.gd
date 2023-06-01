extends Node

#stuff that we want to be able to access anywhere

var screen_resolution
var night = 1

func _ready():
	screen_resolution = get_viewport().size
