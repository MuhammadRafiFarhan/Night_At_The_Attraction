extends Area

const pressed_distance = 0.1 #seberapa jauh tombol tertekan jika ditekan

onready var press_sound = $AudioStreamPlayer3D

var pressed = false #apakah tombol tertekan atau tidak

export(Material) var material

signal pressed
signal unpressed

func _ready():
	#perbedaan satu-satunya antara tombol pintu dan tombol lampu adalah warna/bahan mereka
	#kita dapat mengatur bahan apa yang akan digunakan oleh tombol tersebut di inspector
	#bahan tersebut diterapkan pada saat runtime:
	$MeshInstance.set("material/0", material)

func _on_Button_input_event(camera, event, click_position, click_normal, shape_idx):
	#memeriksa apakah tombol diklik
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		#mengganti nilai variabel "pressed"
		pressed = !pressed
		
		#memeriksa apakah tombol sekarang tertekan, mengeluarkan sinyal, dan memindahkan tombol sesuai dengan kondisi
		if pressed:
			emit_signal("pressed")
			push_in()
			press_sound.play()
		else:
			emit_signal("unpressed")
			push_out()
			press_sound.play()

func push_in(): #jika tertekan, mendorong masuk
	$MeshInstance.transform.origin.x = -pressed_distance

func push_out(): #jika tidak tertekan, mendorong keluar
	$MeshInstance.transform.origin.x = 0
