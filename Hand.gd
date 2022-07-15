extends Spatial

onready var animPlayer = $AnimationPlayer

func throw():
	animPlayer.play("throw")
