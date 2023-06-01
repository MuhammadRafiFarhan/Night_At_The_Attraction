extends Control

#menampilkan static, peta, dan tombol kamera pada layar. Menampilkan dirinya sendiri ketika kamera aktif

func _ready():
	hide()

func _on_Player_turn_on_cams():
	show()

func _on_Player_turn_off_cams():
	hide()

func _on_CameraViewer_changed_cam():
	lose_connection()
	$ChangeCamAudio.play()

func _on_AnimatronicsManager_animatronic_movement():
	lose_connection()

func lose_connection():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("lost_connection")
