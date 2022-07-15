extends Spatial

onready var animationPlayer: AnimationPlayer = $AnimationPlayer



func play(back = false, speed = 1):
	if back:
		animationPlayer.play_backwards("ArmatureAction", speed)
	else:
		animationPlayer.play("ArmatureAction", speed)
