extends Spatial

# node ini mengelola AI animatronic.

# path ke node lain.
onready var game = get_tree().get_root().get_node("Game")
onready var animatronic_one = $AnimatronicOne
onready var animatronic_two = $AnimatronicTwo

# daftar titik-titik tempat animatronik melakukan teleportasi sebelum melakukan jumpscare, titik terakhir stagnan adalah pintu kantor.
const ANIMATRONIC_ONE_INACTIVE_POSITION = Vector3(-1, 1, -44.635)
const ANIMATRONIC_ONE_ACTIVE_POSITIONS = [Vector3(-2.364, 0.5, -18.952), Vector3(-12.503, 0.5, -11.721), Vector3(-4.214, 0.5, 1.636)]
const ANIMATRONIC_TWO_INACTIVE_POSITION = Vector3(1.534, 1, -44.88)
const ANIMATRONIC_TWO_ACTIVE_POSITIONS = [Vector3(2.645, 0.5, -21.397), Vector3(11.679, 0.5, -10.209), Vector3(4.273, 0.5, 1.073)]

#animatronic ai levels bergantung pada malam yang dilalui.
const MAX_AI_LEVEL = 20
const ANIMATRONIC_EXTRA_WAIT_TIME_MAX = 10
const ANIMATRONICS_AI_NIGHT_ONE = [3, 2]
const ANIMATRONICS_AI_NIGHT_TWO = [5, 15]

var animatronics_ai = []

signal animatronic_movement
signal jumpscare(animatronic)

func _ready():
	randomize()
	# letakkan animatronik pada posisi awal mereka dan beri jeda sebelum mereka aktif satu-persatu.
	set_animatronics_to_starting_position()
	match Global.night: #waktu aktivasi animatronic bergantung pada malam yang dilalui
		1:
			animatronics_ai = ANIMATRONICS_AI_NIGHT_ONE
			yield(get_tree().create_timer(20), "timeout")
			activate_animatronic_one()
			yield(get_tree().create_timer(60), "timeout")
			activate_animatronic_two()
		2:
			animatronics_ai = ANIMATRONICS_AI_NIGHT_TWO
			yield(get_tree().create_timer(15), "timeout")
			activate_animatronic_one()
			yield(get_tree().create_timer(10), "timeout")
			activate_animatronic_two()

func activate_animatronic_one():
	#infinite loop yang berlangsung sepanjang malam (batasan 500 iterasi).
	for attack in range(500):
		#loop gerakan teleportasi tiap animatronik dan jeda selama 18-36 detik setelah tiap teleportasi.
		for position in ANIMATRONIC_ONE_ACTIVE_POSITIONS:
			emit_signal("animatronic_movement")
			animatronic_one.global_transform.origin = position
			
			yield(get_tree().create_timer((MAX_AI_LEVEL + 5) - animatronics_ai[0] + rand_range(0, ANIMATRONIC_EXTRA_WAIT_TIME_MAX)), "timeout")
			
			#cek apakah animatronic sudah ada di dekat pintu.
			if position == ANIMATRONIC_ONE_ACTIVE_POSITIONS[-1]:
				#jika pintu tidak tertutup maka lakukan animasi jumpscare.
				if not game.left_door_closed:
					emit_signal("jumpscare", "animatronic_one")

func activate_animatronic_two():
	for attack in range(500):
		for position in ANIMATRONIC_TWO_ACTIVE_POSITIONS:
			emit_signal("animatronic_movement")
			animatronic_two.global_transform.origin = position
			
			yield(get_tree().create_timer((MAX_AI_LEVEL + 3) - animatronics_ai[1] + rand_range(0, ANIMATRONIC_EXTRA_WAIT_TIME_MAX)), "timeout")
			
			if position == ANIMATRONIC_TWO_ACTIVE_POSITIONS[-1]:
				if not game.right_door_closed:
					emit_signal("jumpscare", "animatronic_two")

func set_animatronics_to_starting_position():
	animatronic_one.global_transform.origin = ANIMATRONIC_ONE_INACTIVE_POSITION
	animatronic_two.global_transform.origin = ANIMATRONIC_TWO_INACTIVE_POSITION
