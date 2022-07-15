extends Spatial

onready var animPlayer = $AnimationPlayer

signal thrown

func throw():
	animPlayer.play("throw")


func end_throw():
	emit_signal("thrown")
