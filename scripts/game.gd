extends Spatial

#menyimpan status pintu/lampu serta status monitor. node-node lain dapat mengakses variabel-variabel ini dengan mudah

var left_door_closed = false
var right_door_closed = false
var left_light_on = false
var right_light_on = false
var cameras_on = false
var out_of_power = false

func _on_Player_turn_on_cams():
	cameras_on = true

func _on_Player_turn_off_cams():
	cameras_on = false

func _on_Power_out_of_power():
	out_of_power = true
	$MainLight.hide()
