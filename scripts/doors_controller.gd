extends Spatial

#mengatur tombol pintu untuk open/close

onready var game = get_tree().get_root().get_node("Game")

func _on_DoorButtonLeft_pressed():
	if game.out_of_power: return
	$LeftDoor.close()
	game.left_door_closed = true

func _on_DoorButtonRight_pressed():
	if game.out_of_power: return
	$RightDoor.close()
	game.right_door_closed = true

func _on_DoorButtonLeft_unpressed():
	if game.out_of_power: return
	$LeftDoor.open()
	game.left_door_closed = false

func _on_DoorButtonRight_unpressed():
	if game.out_of_power: return
	$RightDoor.open()
	game.right_door_closed = false


func _on_Power_out_of_power():
	$LeftDoor.open()
	game.left_door_closed = false
	
	$RightDoor.open()
	game.right_door_closed = false
