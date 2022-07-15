extends Spatial

onready var animPlayer = $AnimationPlayer
onready var hand = $hand

signal thrown

func _ready():
	animPlayer.current_animation = "throw"
	animPlayer.seek(0.001, true)
	animPlayer.stop()

func throw():
	animPlayer.play("throw")


func end_throw():
	emit_signal("thrown")
