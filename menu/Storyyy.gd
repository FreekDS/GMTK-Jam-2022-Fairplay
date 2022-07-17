extends Control


func _ready():
	$Panel1.visible = true
	$Panel1.play()


func _input(event):
	if event.is_action_pressed("mouse_down"):
		if $Panel1.completed and not $Panel2.playing and not $Panel2.completed:
			$Panel1.visible = false
			$Panel2.visible = true
			$Panel2.play()
		elif $Panel1.playing:
			$Panel1.skip()
		elif $Panel2.completed:
			# start game
			get_tree().change_scene("res://game.tscn")
		elif $Panel2.playing:
			$Panel2.skip()

