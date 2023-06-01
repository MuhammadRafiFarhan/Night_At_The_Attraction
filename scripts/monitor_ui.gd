extends Control


var monitor_up = false

signal monitor_on
signal monitor_off

func _on_MonitorButton_mouse_entered():
	if monitor_up:
		monitor_up = false
		emit_signal("monitor_off")
	else:
		monitor_up = true
		emit_signal("monitor_on")

func _on_Player_lower_monitor():
	monitor_up = false
	emit_signal("monitor_off")
