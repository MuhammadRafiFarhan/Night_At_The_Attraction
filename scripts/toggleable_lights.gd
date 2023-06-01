extends Spatial

onready var game = get_tree().get_root().get_node("Game")

func _on_LightButtonLeft_pressed():
	if game.out_of_power: return
	$LeftLight.visible = true
	game.left_light_on = true

func _on_LightButtonLeft_unpressed():
	if game.out_of_power: return
	$LeftLight.visible = false
	game.left_light_on = false

func _on_LightButtonRight_pressed():
	if game.out_of_power: return
	$RightLight.visible = true
	game.right_light_on = true

func _on_LightButtonRight_unpressed():
	if game.out_of_power: return
	$RightLight.visible = false
	game.right_light_on = false


func _on_Power_out_of_power():
	$LeftLight.visible = false
	game.left_light_on = false
	
	$RightLight.visible = false
	game.right_light_on = false
