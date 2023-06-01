extends Control

func _ready():
	yield(get_tree().create_timer(4), "timeout")
	get_tree().change_scene("res://scenes/menu.tscn")
