extends Control

onready var transition_anim = $Transition/AnimationPlayer

func _on_Night1_button_down():
	start_night(1)

func _on_Night2_button_down():
	start_night(2)

func _on_Exit_button_down():
	transition_anim.play("fade_to_black")
	yield(transition_anim, "animation_finished")
	get_tree().quit()

func start_night(what_night):
	transition_anim.play("fade_to_black")
	yield(transition_anim, "animation_finished")
	Global.night = what_night
	get_tree().change_scene("res://scenes/game.tscn")
