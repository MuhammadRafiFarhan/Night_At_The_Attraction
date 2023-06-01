extends Spatial

onready var anim = $AnimationPlayer

func open():
	anim.play("open")

func close():
	anim.play("close")
