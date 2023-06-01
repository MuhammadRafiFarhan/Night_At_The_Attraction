extends Spatial

var cam = 1

onready var cams = [$Cam1, $Cam2, $Cam3, $Cam4]

signal changed_cam

#menyembunyikan kamera-kamera pada awal permainan
func _ready():
	turn_off_cams()

#fungsi yang membuat semua kamera tidak menjadi "current" dan menyembunyikan node-node "Camera1, Camera2, ..."
func turn_off_cams():
	for i in get_children():
		if i.is_in_group("cam"):
			i.hide()
			i.get_node("Camera").current = false

func _on_Player_turn_on_cams():
	display_current_cam()

func _on_Player_turn_off_cams():
	turn_off_cams()

#menyembunyikan semua kamera dan kemudian menampilkan kamera saat ini
func display_current_cam():
	turn_off_cams()
	cams[cam - 1].show()
	cams[cam - 1].get_node("Camera").current = true

func change_cam_to(to_this_cam):
	cam = to_this_cam
	display_current_cam()
	emit_signal("changed_cam")


func _on_Button1_button_down():
	change_cam_to(1)

func _on_Button2_button_down():
	change_cam_to(2)

func _on_Button3_button_down():
	change_cam_to(3)

func _on_Button4_button_down():
	change_cam_to(4)
