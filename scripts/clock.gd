extends Control

#menampilkan waktu. jika jam mencapai 6, scene diganti

onready var hour_label = $MarginContainer/HBoxContainer/VBoxContainer/Hour

var hours = ["12AM", "1AM", "2AM", "3AM", "4AM", "5AM", "6AM"]
var hour = 0

func _ready():
	hour_label.text = hours[hour]

func _on_HourTimer_timeout():
	#setiap kali timer selesai menghitung, label diubah untuk menampilkan jam berikutnya
	hour += 1
	hour_label.text = hours[hour]
	
	if hour == 6:
		get_tree().change_scene("res://scenes/six_am.tscn")

func _on_Power_out_of_power():
	hide()
