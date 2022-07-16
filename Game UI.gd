extends Control


func _input(event):
	if event.is_action_pressed("mouse_down"):
		$"SUS Meter".add(20)
	if event.is_action("slowmo"):
		$"SUS Meter".add(-20)
