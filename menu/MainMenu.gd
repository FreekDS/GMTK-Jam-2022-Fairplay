extends Control



func _on_Credits_pressed():
	$MainMenu.visible = false
	$Credits.visible = true


func _on_BackButton_pressed():
	$MainMenu.visible=true
	$Credits.visible=false


func _on_PlayButton_pressed():
	print("Play")
