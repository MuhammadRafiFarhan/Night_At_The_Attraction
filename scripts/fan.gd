extends Spatial

func _on_Power_out_of_power():
	$AnimationPlayer.play("inactive")
	$FanSound.stop()
