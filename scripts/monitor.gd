extends Spatial

#animasi saat membuka CCTV

onready var anim = $AnimationPlayer

func _on_MonitorUI_monitor_off():
	anim.play("monitor_off")

func _on_MonitorUI_monitor_on():
	anim.play("monitor_on")
